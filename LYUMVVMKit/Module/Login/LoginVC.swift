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
        tf.backgroundColor = UIColor.gray
        return tf;
    }()
    var pwdTF:UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.gray
        return tf;
    }()
    
    
    var confirmPwdTF:UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.gray
        return tf;
    }()
    
    let desLab = UILabel()
    
    
    var loginBtn:UIButton = {
        let btn = UIButton()
        return btn;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()/// 初始化UI
        bindView()/// 绑定视图的业务逻辑
    }
    
    let viewModel = LoginVM()
    
}

extension LoginVC
{
    fileprivate func setupUI(){
        self.view.addSubview(accountTF)
        self.view.addSubview(pwdTF)
        view.addSubview(confirmPwdTF)
        
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
        confirmPwdTF.snp.makeConstraints { (make) in
             make.centerX.width.height.equalTo(self.accountTF);
            make.top.equalTo(self.pwdTF.snp.bottom).offset(FIT_WIDTH(100));
            
        }
        
    }
}


extension LoginVC
{
    fileprivate func bindView(){
      
     let vmInput =   LoginVM.Input(username: self.accountTF.rx.text.orEmpty.asDriver(), password: self.pwdTF.rx.text.orEmpty.asDriver(), repeatedPassword: self.confirmPwdTF.rx.text.orEmpty.asDriver(), loginTaps: self.loginBtn.rx.tap.asSignal());
        

       
        
        
        
    }
}
