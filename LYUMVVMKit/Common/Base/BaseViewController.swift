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
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = UIColor.white
//        self.shouldAutorotate = false;
//        self.supportedInterfaceOrientations = .landscape;
//        preferredInterfaceOrientationForPresentation = .landscapeLeft;
    }

    
   

    deinit {
        LLog("释放了")
    }
}
