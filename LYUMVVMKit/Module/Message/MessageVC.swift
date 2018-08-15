//
//  MessageVC.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class MessageVC: BaseViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        let lab = UILabel()
        lab.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
        lab.backgroundColor = UIColor.gray;
        lab.layer.cornerRadius = 10;
        lab.layer.masksToBounds = false;
        lab.layer.shadowRadius = 10;
        lab.layer.shadowColor = UIColor.red.cgColor;
        lab.layer.shadowOffset = CGSize(width: -5, height: -5)
        lab.layer.shadowOpacity = 1;
        
        self.view.addSubview(lab)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
//        LYURouter.open(vc: LoginVC());
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
