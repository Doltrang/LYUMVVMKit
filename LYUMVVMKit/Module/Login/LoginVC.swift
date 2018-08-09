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
        btn.setTitle("登录", for: .normal);
        btn.setTitleColor(UIColor.red, for: .normal);
        btn.setNeedsCameraPermission();
        return btn;
    }()
    
    
    var testBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal);
        btn.setTitleColor(UIColor.red, for: .normal);
        btn.setNeedsCameraPermission();
        
        return btn;
    }()
    
    
    let viewModel = LoginVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        setupUI()/// 初始化UI
        bindView()/// 绑定视图的业务逻辑
    }
    
    
    
}

extension LoginVC
{
    fileprivate func setupUI(){
        self.view.addSubview(accountTF)
        self.view.addSubview(pwdTF)
        view.addSubview(confirmPwdTF)
        view.addSubview(loginBtn);
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
            make.bottom.equalTo(self.view.snp.bottom).offset(FIT_WIDTH(100));
            
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview();
            make.width.equalTo(FIT_WIDTH(120));
            make.height.equalTo(FIT_WIDTH(40));
            make.top.equalTo(confirmPwdTF.snp.bottom).offset(FIT_WIDTH(40));
        }
        loginBtn.addTarget(self, action: #selector(showToast), for: .touchUpInside);
        
        
        view.addSubview(self.testBtn);
        self.testBtn.snp.makeConstraints { (make) in
            make.left.equalTo(100);
            make.width.height.equalTo(200);
            make.top.equalTo(self.loginBtn.snp.bottom).offset(100);
        }
        
        
        
        UIView.animate(withDuration: 1) {
            self.testBtn.snp.updateConstraints { (make) in
                make.left.equalTo(200);
            }
            self.testBtn.layoutIfNeeded();
        }
    }
}


extension LoginVC
{
    fileprivate func bindView(){
      
     let vmInput =   LoginVM.Input(username: self.accountTF.rx.text.orEmpty.asDriver(), password: self.pwdTF.rx.text.orEmpty.asDriver(), repeatedPassword: self.confirmPwdTF.rx.text.orEmpty.asDriver(), loginTaps: self.loginBtn.rx.tap.asSignal());
        

       
        
        
        
    }
    
    @objc fileprivate func showToast(){
       
      
    }
}
