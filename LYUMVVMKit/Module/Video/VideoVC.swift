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
        let lab = UILabel()
        self.view.addSubview(lab);
        
        lab.text = "213123123"
        lab.backgroundColor = UIColor.red
        lab.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo("".textWidth(font: lab.font, height: FIT_WIDTH(80)))
            make.height.equalTo(FIT_WIDTH(80));
            make.center.equalTo(self.view);
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
