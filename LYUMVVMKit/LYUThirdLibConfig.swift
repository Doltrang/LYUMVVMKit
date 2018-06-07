//
//  LYUThirdLibConfig.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import SnapKit
import Then
import HandyJSON
import RxCocoa
import RxDataSources
import RxSwift
import SVProgressHUD
import IQKeyboardManagerSwift


extension AppDelegate
{
    
    //MARK:-初始化显示弹框
    fileprivate  func initHUDStyle(){
        SVProgressHUD.setBackgroundColor(UIColor.white);
        SVProgressHUD.setForegroundColor(UIColor.black);
        SVProgressHUD.setDefaultStyle(.custom);
        SVProgressHUD.setDefaultMaskType(.black);
    }
    
    fileprivate   func initKeyboardManager(){
        //自定义键盘
        IQKeyboardManager.sharedManager().enable = true;
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true;
        IQKeyboardManager.sharedManager().shouldToolbarUsesTextFieldTintColor = true;
        IQKeyboardManager.sharedManager().enableAutoToolbar = false;
        
    }
    
    
//    fileprivate func initToastStyle(){
//
//        var style = ToastStyle()
//        style.messageColor = .black
//        style.backgroundColor = .white;
//        ToastManager.shared.style = style
//        ToastManager.shared.tapToDismissEnabled = true
//        ToastManager.shared.queueEnabled = true
//        ToastManager.shared.position = .center;
//
//    }
    
}


