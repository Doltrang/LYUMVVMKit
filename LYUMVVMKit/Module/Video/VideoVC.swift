//
//  VideoVC.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit
import SnapKit
class VideoVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = LYUCardView.init(frame: CGRect.zero);
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview();
            make.top.equalTo(FIT_WIDTH(300));
            make.height.equalTo(400);
        }
        v.backgroundColor = UIColor.red
        
        
        
//        for i in 0..<3{
//            LLog(i);
//            let v = LYUBasePopWindow(frame: self.view.bounds);
//            v.backgroundColor = UIColor.random()
//            v.lab.text = "\(i)"
//            LYUPopWindowManager.shareManager.showPopView(popView: v);
//        }
//
//        self.view.backgroundColor = UIColor.red;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 



}
