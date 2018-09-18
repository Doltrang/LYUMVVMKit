//
//  BaseViewController.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/22.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    lazy var backBtn:UIButton = {
        let btn = UIButton(type: .custom);
        btn.setImage(#imageLiteral(resourceName: "backLeft"), for: .normal)
        return btn;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(FIT_WIDTH(65))
            make.top.equalTo(FIT_WIDTH(66))
            make.width.equalTo(FIT_WIDTH(66))
           
        }
//        self.shouldAutorotate = false;
//        self.supportedInterfaceOrientations = .landscape;
//        preferredInterfaceOrientationForPresentation = .landscapeLeft;
        backBtn.rx.tap.subscribe(onNext: {
            self.navigationController?.popViewController(animated: false);
        }).disposed(by: disposeBag)
    }

    
   

    deinit {
        LLog("释放了")
    }
}
