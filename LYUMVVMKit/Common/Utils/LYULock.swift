//
//  LYULock.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/11.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

// http://swift.gg/2018/06/07/friday-qa-2015-02-06-locks-thread-safety-and-swift/
import Foundation
/*
 锁（lock）或者互斥锁（mutex）是一种结构，用来保证一段代码在同一时刻只有一个线程执行。它们通常被用来保证多线程访问同一可变数据结构时的数据一致性。主要有下面几种锁
 
 1、阻塞锁（Blocking locks）：常见的表现形式是当前线程会进入休眠，直到被其他线程释放
 2、自旋锁（Spinlocks): 使用一个循环不断地检查锁是否被释放。如果等待情况很少话这种锁是非常高效的，相反，等待情况非常多的情况下会浪费 CPU 时间
 3、读写锁（Reader/writer locks）：允许多个读线程同时进入一段代码，但当写线程获取锁时，其他线程（包括读取器）只能等待。这是非常有用的，因为大多数数据结构读取时是线程安全的，但当其他线程边读边写时就不安全了。
 4、递归锁（Recursive locks）：允许单个线程多次获取相同的锁。非递归锁被同一线程重复获取时可能会导致死锁、崩溃或其他错误行为
 
 pthread_mutex_t 是一个可选择性地配置为递归锁的阻塞锁
 pthread_rwlock_t 是一个阻塞读写锁
 dispatch_queue_t 可以用作阻塞锁，也可以通过使用 barrier block 配置一个同步队列作为读写锁，还支持异步执行加锁代码
 NSOperationQueue 可以用作阻塞锁。与 dispatch_queue_t 一样，支持异步执行加锁代码。( 当配置为 serial 时)
 NSLock 是 Objective-C 类的阻塞锁，它的同伴类 NSRecursiveLock 是递归锁
 OSSpinLock 顾名思义，是一个自旋锁
 
 除此之外，Objective-C 提供了 @synchronized 语法结构，它其实就是封装了 pthread_mutex_t 。与其他 API 不同的是，@synchronized 并未使用专门的锁对象，它可以将任意 Objective-C 对象视为锁。@synchronized(someObject) 区域会阻止其他 @synchronized(someObject) 区域访问同一对象指针。swift中
 等同于 objc_sync_enter(someObject);
       {....}
       objc_sync_exit(someObject);
 
 
 ================
 
 
 注意，pthread_mutex_t，pthread_rwlock_t 和 OSSpinLock 是值类型，而不是引用类型。这意味着如果你用 = 进行赋值操作，实际上会复制一个副本。这会造成严重的后果，因为这些类型无法复制！如果你不小心复制了它们中的任意一个，这个副本无法使用，如果使用可能会直接崩溃。这些类型的 pthread 函数会假定它们的内存地址与初始化时一样，因此如果将它们移动到其他地方就可能会出问题。OSSpinLock 不会崩溃，但复制操作会生成一个完全独立的锁，这不是你想要的。
 
 如果使用这些类型，就必须注意不要去复制它们，无论是显式的使用 = 操作符还是隐式地操作。
 例如，将它们嵌入到结构中或在闭包中捕获它们。
 
 另外，由于锁本质上是可变对象，需要用 var 来声明它们。
 
 其他锁都是是引用类型，它们可以随意传递，并且可以用 let 声明。
 
 */

/*
 互斥锁，当一个线程获得这个锁之后，其他想要获得此锁的线程将会被阻塞，直到该锁被释放
 * 但是如果连续锁定两次，则会造成死锁问题。如果想在递归中使用锁，就要用到了 RecursiveLock 递归锁。
 */

/*
 *互斥锁与读写锁的区别：
 
 *当访问临界区资源时（访问的含义包括所有的操作：读和写），需要上互斥锁；
 
 *当对数据（互斥锁中的临界区资源）进行读取时，需要上读取锁，当对数据进行写入时，需要上写入锁。
 
 *读写锁的优点：
 
 *对于读数据比修改数据频繁的应用，用读写锁代替互斥锁可以提高效率。因为使用互斥锁时，即使是读出数据（相当于操作临界区资源）都要上互斥锁，而采用读写锁，则可以在任一时刻允许多个读出者存在，提高了更高的并发度，同时在某个写入者修改数据期间保护该数据，以免任何其它读出者或写入者的干扰。
 */

/// 定义锁操作协议
protocol LYULockable: class {
    func lock()
    func unlock()
}

// MARK:自旋锁
/*
 自旋锁，当一个线程获得锁之后，其他线程将会一直循环在哪里查看是否该锁被释放。适用于锁的持有者保存时间较短的情况下
 *OSSpinLock已经不再安全,会出现优先级反转的问题。
 */
@available(iOS 10.0, OSX 10.12, watchOS 3.0, tvOS 10.0, *)
fileprivate  class LYUUnfairLock: LYULockable {
    private var unfairLock = os_unfair_lock_s()
    
    func lock() {
        os_unfair_lock_lock(&unfairLock)
    }
    
    func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }
}

fileprivate  class LYUMutex: LYULockable {
    private var mutex = pthread_mutex_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}


// MARK:递归锁
/*
 * 递归锁  防止一个线程多次加锁 造成死锁
 *递归锁会发生死锁。多数情况下它们是有用的，但如果你发现自己需要获取一个已经在当前线程被锁住的锁，那最好重新设计代码，通常来说不会出现这种需求
 */

fileprivate final class LYURecursiveMutex: LYULockable {
    private var mutex = pthread_mutex_t()
    
    init() {
        var attr = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attr)
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}

// MARK:读写锁
/*
 * 读写锁
 * 用来解决读写问题的，读操作可以共享，写操作是排他的，读可以有多个在读，写只有唯一个在写，同时写的时候不允许读
 * 一般来说不需要用读写锁，大多数情况下读写速度都非常快。读写锁带来的额外开销超过了并发读取带来的效率提升
 */
fileprivate final class LYUReadWriteLock:LYULockable
{
    private var rwlock_t = pthread_rwlock_t();
    private var rwlock_a = pthread_rwlockattr_t()
    init() {
        pthread_rwlock_init(&rwlock_t, &rwlock_a)
    }
    deinit {
        pthread_rwlock_destroy(&rwlock_t)
    }
    /// 写入锁
    func lock() {
        pthread_rwlock_wrlock(&rwlock_t)
    }
    
    func unlock() {
        pthread_rwlock_unlock(&rwlock_t)
    }
    
}
// MARK:自旋锁
/// 自旋锁
fileprivate final class LYUSpin: LYULockable {
    private let locker: LYULockable
    init() {
        if #available(iOS 10.0, macOS 10.12, watchOS 3.0, tvOS 10.0, *) {
            locker = LYUUnfairLock()
        } else {
            locker = LYUMutex()
        }
    }
    
    func lock() {
        locker.lock()
    }
    
    func unlock() {
        locker.unlock()
    }
}


// MARK:条件锁
/// 条件锁
fileprivate final class LYUConditionLock: LYULockable {
    private var mutex = pthread_mutex_t()
    private var cond = pthread_cond_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
//        pthread_mutex_t()
        pthread_cond_init(&cond, nil)
    }
    
    deinit {
        pthread_cond_destroy(&cond)
        pthread_mutex_destroy(&mutex)
    }
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
    
    func wait() {
        pthread_cond_wait(&cond, &mutex)
    }
    
    func wait(timeout: TimeInterval) {
        let integerPart = Int(timeout.nextDown)
        let fractionalPart = timeout - Double(integerPart)
        var ts = timespec(tv_sec: integerPart, tv_nsec: Int(fractionalPart * 1000000000))
        
        pthread_cond_timedwait_relative_np(&cond, &mutex, &ts)
    }
    
    func signal() {
        pthread_cond_signal(&cond)
    }
}


// MARK:锁对象操作
//// 锁对象操作(处理多线程操作)
class LYULock: NSObject {
    
    static let shareLockManager:LYULock = {
        let lock = LYULock();
        return lock;
    }()
    fileprivate var condition_lock = LYUConditionLock();
    
    /// synchronized锁 互斥锁 性能较差
    ///
    /// - Parameters:
    ///   - lock: 锁对象 实际上是把这个对象当做锁来使用。通过一个哈希表来实现的，OC 在底层使用了一个互斥锁的数组(你可以理解为锁池)，通过对对象去哈希值来得到对应的互斥锁。
    ///   - closure: 闭包
    ///
    func synchronizedLock(lock: AnyObject, closure: () -> ()){
        objc_sync_enter(lock);
        closure();
        objc_sync_exit(lock);
    }
    
    /// 条件锁
    ///
    /// - Parameter closure: 执行代码
    func conditionLock(closure: () -> ()){
        condition_lock.lock();
        closure()
        condition_lock.unlock();
        
    }
    
    
    
}



extension pthread_mutex_t {
    init() {
        __sig = 0
        __opaque = (0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0)
    }
}

extension pthread_rwlock_t {
    init() {
        __sig = 0
        __opaque = (0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0)
    }
}

