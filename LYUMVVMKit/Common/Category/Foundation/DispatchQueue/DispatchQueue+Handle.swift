//
//  DispatchQueue+Handle.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
public extension DispatchQueue {
    
    
    // MARK:delay time to do
    public class func dispatch_after(_ delayInSeconds:Double,block:@escaping ()->()){
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute:block);
    }
    
    ///  Submits a block for asynchronous execution on the main queue
    public static func runThisInMainThread(_ block: @escaping () -> Void) {
        if(Thread.current.isMainThread){
            block()
        }else{
            DispatchQueue.main.async(execute: block)
        }
        
    }
    
    ///  Runs in Default priority queue
    public static func runThisInBackground(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    ///  Runs every second, to cancel use: timer.invalidate()
    @discardableResult public static func runThisEvery(
        seconds: TimeInterval,
        startAfterSeconds: TimeInterval,
        handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = startAfterSeconds + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
}
