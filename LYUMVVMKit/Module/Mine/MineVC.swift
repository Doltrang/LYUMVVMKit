//
//  MineVC.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class MineVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       let v = LYUDynamicView(frame: CGRect.zero)
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.view);
            make.width.height.equalToSuperview()
        }
        v.backgroundColor =  UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
