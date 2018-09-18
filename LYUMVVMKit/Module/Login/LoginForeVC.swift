//
//  LoginForeVC.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/8/26.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import SnapKit


import RxSwift
import RxCocoa

class LoginForeVC: BaseViewController {
    
    lazy var skipBtn:LYUContentLayoutBtn = {
        let btn = LYUContentLayoutBtn();
        btn.setTitle("先逛一逛 >>", for:.normal);
        btn.setTitleColor(UIColor.init(hexString: "CFCFCF"), for: .normal)
        btn.titleLabel?.font = FONT(28);
        return btn;
    }()
    
    
    lazy var logingLogoImageV:UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "illustrations");
        return img;
    }()
    
    lazy var loginInfoLab:UILabel = {
        let lab = UILabel()
         lab.textColor = UIColor.init(hexString: "AAAAAA")
        lab.font = FONT(28);
        lab.textAlignment = .center;
        lab.text = "一眼就让孩子爱上阅读的动画书"
        return lab;
    }()
    
    lazy var loginBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal);
        btn.setTitleColor(UIColor.init(hexString: "40D8B1"), for: .normal)
        btn.titleLabel?.font = FONT(32);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = FIT_WIDTH(47);
        btn.layer.borderWidth = FIT_WIDTH(3);
        btn.layer.borderColor = UIColor.init(hexString: "40D8B1")?.cgColor
        
        return btn;
    }()
    
    lazy var registerBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", for: .normal);
        btn.setTitleColor(UIColor.init(hexString: "40D8B1"), for: .normal)
        btn.titleLabel?.font = FONT(32);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = FIT_WIDTH(47);   
        
        return btn;
    }()

    
    fileprivate var vm:LoginForeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad();

        setupUI();
        bindUI();
    }
}


extension LoginForeVC{
    fileprivate func setupUI(){
        /// 初始化UI
        self.view.addSubview(self.skipBtn);
        self.skipBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-FIT_WIDTH(34));
            make.top.equalTo(self.view).offset(FIT_WIDTH(94))
            make.height.equalTo(FIT_WIDTH(40));
            make.width.greaterThanOrEqualTo(FIT_WIDTH(40));
        }
        
        
        
        self.view.addSubview(self.logingLogoImageV);
        self.logingLogoImageV.snp.makeConstraints { (make) in
            make.width.equalTo(FIT_WIDTH(542))
            make.height.equalTo(FIT_WIDTH(488))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.skipBtn.snp.bottom).offset(FIT_WIDTH(64));
        }
        
        self.view.addSubview(self.loginInfoLab)
        
        var topConstraint:Constraint? = nil
        self.loginInfoLab.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
            make.height.equalTo(FIT_WIDTH(40))
            make.top.equalTo(self.logingLogoImageV.snp.bottom).offset(FIT_WIDTH(47))
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(FIT_WIDTH(100)).offset(100);
            topConstraint = make.width.greaterThanOrEqualTo(FIT_WIDTH(100)).offset(10).constraint
        }

   
        self.loginInfoLab.backgroundColor =  UIColor.red
        self.view.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) in
            make.width.equalTo(FIT_WIDTH(289))
            make.height.equalTo(FIT_WIDTH(94))
            make.right.equalTo(self.view.snp.centerX).offset(-FIT_WIDTH(27));
            make.top.equalTo(self.logingLogoImageV.snp.bottom).offset(FIT_WIDTH(343))
            
        }
        
        self.view.addSubview(self.registerBtn);
        self.registerBtn.snp.makeConstraints { (make) in
            make.width.height.centerY.equalTo(self.loginBtn)
            make.left.equalTo(self.view.snp.centerX).offset(FIT_WIDTH(27));
        }
    }
   
}

extension LoginForeVC{
    fileprivate func bindUI(){
        self.vm = LoginForeVM()
        self.vm.transform(skip: self.skipBtn.rx.tap.asSignal(), register: self.registerBtn.rx.tap.asSignal(), login: self.loginBtn.rx.tap.asSignal());
        
//        self.loginBtn.rx.tap.subscribe(onNext: {
//            self.logingLogoImageV.pop()
//        })
//            .disposed(by: disposeBag)
//
//
//        self.registerBtn.rx.tap.subscribe(onNext: {
//            self.logingLogoImageV.popBig()
//        })
//            .disposed(by: disposeBag)
    }
}
