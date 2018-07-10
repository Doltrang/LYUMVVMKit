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
        let lab : LYUContentLayoutBtn =  LYUContentLayoutBtn(type: .custom);
        lab.layoutContent(style: .ImageTop, imgSize: CGSize(width: 30, height: 30), space: 10);
        lab.setImage(#imageLiteral(resourceName: "read_share.png"), for: .normal);
        lab.setTitle("qweqweqweqweqweqweqw", for: .normal);
        lab.setTitleColor(UIColor.black, for: .normal)
        lab.titleLabel?.font = FONT(40);
        lab.titleLabel?.numberOfLines = 0;
        self.view.addSubview(lab);
        lab.titleLabel?.backgroundColor = .red
      let h =   lab.titleLabel?.textRect(forBounds: CGRect(x: 0, y: 0, width: FIT_WIDTH(200), height: CGFloat(MAXFLOAT)), limitedToNumberOfLines: 0).size.height ?? 0;
        lab.snp.makeConstraints { (make) in
            make.left.top.equalTo(FIT_WIDTH(40));
            make.width.equalTo(FIT_WIDTH(200));
            make.height.equalTo(h + 40)
        }
        
        
        
        let lab2 : LYUContentLayoutBtn =  LYUContentLayoutBtn(type: .custom);
        lab2.layoutContent(style: .ImageTop, imgSize: CGSize(width: 30, height: 30), space: 10);
        lab2.setImage(#imageLiteral(resourceName: "read_share.png"), for: .normal);
        lab2.setTitle("qwew", for: .normal);
        lab2.setTitleColor(UIColor.black, for: .normal)
        lab2.titleLabel?.font = FONT(40);
        lab2.titleLabel?.numberOfLines = 0;
        self.view.addSubview(lab2);
        lab2.titleLabel?.backgroundColor = .blue
        lab2.snp.makeConstraints { (make) in
            make.top.equalTo(FIT_WIDTH(40));
            make.left.equalTo(FIT_WIDTH(400))
            make.width.equalTo(FIT_WIDTH(200));
            make.height.equalTo(FIT_WIDTH(200))
        }
        
        
        
        let lab3 = UILabel();
        lab3.text = "qweqweqweqweqweqweqw"
        lab3.font = FONT(40);
        lab3.numberOfLines = 0;
        
        self.view.addSubview(lab3)
        
        lab3.snp.makeConstraints { (make) in
            make.top.equalTo(FIT_WIDTH(300))
            make.left.equalTo(FIT_WIDTH(200))
            make.width.equalTo(FIT_WIDTH(200));
            make.height.greaterThanOrEqualTo(FIT_WIDTH(80))
        }
        lab3.backgroundColor = UIColor.yellow
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
