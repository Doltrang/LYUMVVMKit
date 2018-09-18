//
//  AppDelegate.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/14.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
  
         initThirdConfig();/// 初始化第三方插件
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white;
        self.window?.rootViewController = BaseNavigationController(rootViewController: LoginForeVC());
//        self.window?.rootViewController = LoginVC();
       self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if UIDevice.isPad{
            return .landscape;
        }
        return .all
    }
    
    
    func addObserver(){
        // 1. 创建监听者
        /**
         *  创建监听者
         *
         *  @param allocator#>  分配存储空间
         *  @param activities#> 要监听的状态
         *  @param repeats#>    是否持续监听
         *  @param order#>      优先级, 默认为0
         *  @param observer     观察者
         *  @param activity     监听回调的当前状态
         */
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0) { (observer, activity) in
            /*
             kCFRunLoopEntry = (1UL << 0),          进入工作
             kCFRunLoopBeforeTimers = (1UL << 1),   即将处理Timers事件
             kCFRunLoopBeforeSources = (1UL << 2),  即将处理Source事件
             kCFRunLoopBeforeWaiting = (1UL << 5),  即将休眠
             kCFRunLoopAfterWaiting = (1UL << 6),   被唤醒
             kCFRunLoopExit = (1UL << 7),           退出RunLoop
             kCFRunLoopAllActivities = 0x0FFFFFFFU  监听所有事件
             */
            
            switch (activity) {
            case CFRunLoopActivity.entry:
                debugPrint("进入");
                break;
            case CFRunLoopActivity.beforeTimers:
                debugPrint("即将处理Timer事件");
                break;
            case CFRunLoopActivity.beforeSources:
                debugPrint("即将处理Source事件");
                break;
            case CFRunLoopActivity.beforeWaiting:
                debugPrint("即将休眠");
                break;
            case CFRunLoopActivity.afterWaiting:
                debugPrint("被唤醒");
                break;
            case CFRunLoopActivity.exit:
                debugPrint("退出RunLoop");
                break;
            default:
                break;
            }
            
        }
        
        
        // 2. 添加监听者
        /**
         *  给指定的RunLoop添加监听者
         *
         *  @param rl#>       要添加监听者的RunLoop
         *  @param observer#> 监听者对象
         *  @param mode#>     RunLoop的运行模式, 填写默认模式即可
         */
   
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, CFRunLoopMode.defaultMode);
        
    }

        
       

    }
    
    
    


