//
//  LoginVC.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/14.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    var accountTF:UITextField = {
        let tf = UITextField()
        return tf;
    }()
    var pwdTF:UITextField = {
        let tf = UITextField()
        return tf;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setupUI();
        
    }


    

}

extension LoginVC
{
    fileprivate func setupUI(){
        self.view.addSubview(accountTF)
        self.view.addSubview(pwdTF)
        self.accountTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view);
            make.width.equalTo(FIT_WIDTH(400))
            make.height.equalTo(FIT_WIDTH(80))
            make.topMargin.equalTo(self.view.snp.top).offset(FIT_WIDTH(80))
        }
        
        
        self.pwdTF.snp.makeConstraints { (make) in
            make.centerX.width.height.equalTo(self.accountTF);
            make.top.equalTo(self.accountTF.snp.bottom).offset(FIT_WIDTH(100))
        }
        
        
    }
}


