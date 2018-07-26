//
//  BaseViewController.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/22.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
//        self.shouldAutorotate = false;
//        self.supportedInterfaceOrientations = .landscape;
//        preferredInterfaceOrientationForPresentation = .landscapeLeft;
    }
  
    //开启 push视图 右滑手势
    fileprivate func openSwipe(){
        if(self.navigationController != nil){
            self.navigationController!.interactivePopGestureRecognizer!.delegate = self;
        }
        
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.navigationController?.viewControllers.count == 1{
            return false;
        }
        return true;
    }

    deinit {
        LLog("释放了")
    }
}
