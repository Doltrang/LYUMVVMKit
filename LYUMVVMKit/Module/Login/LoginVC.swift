//
//  LoginVC.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/14.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {

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
    
    fileprivate var loginHeadLab:UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "333333");
        lab.font = FONT(60);
        lab.text = "登录"
        return lab;
    }()
    
    fileprivate var loginInfoLab:UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "9B9B9B");
        lab.font = FONT(26)
        lab.text = "一眼就让孩子爱上阅读的动画书"
        return lab;
    }()


    
    var loginBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal);
        btn.setTitleColor(UIColor.red, for: .normal);
        return btn;
    }()
    
    

    
    
    let viewModel = LoginVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        setupUI()/// 初始化UI
        bindView()/// 绑定视图的业务逻辑
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
  
    }
    
}

extension LoginVC
{
    fileprivate func setupUI(){
//        self.view.addSubview(self.loginHeadLab);
//        self.loginHeadLab.snp.makeConstraints { (make) in
//
//        }
//
//        self.view.addSubview(self.loginInfoLab);
     
        
        self.view.backgroundColor = .red;
        
        
      
    }
}


extension LoginVC
{
    fileprivate func bindView(){
//
//     let vmInput =   LoginVM.Input(username: self.accountTF.rx.text.orEmpty.asDriver(), password: self.pwdTF.rx.text.orEmpty.asDriver(), repeatedPassword: self.confirmPwdTF.rx.text.orEmpty.asDriver(), loginTaps: self.loginBtn.rx.tap.asSignal());
        

       
        
        
        
    }
    
    @objc fileprivate func showToast(){
       
      
    }
}
