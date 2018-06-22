//
//  BaseNavigationController.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/22.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
       setUpNavigationBarAppearance();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /// 推出视图
    ///
    /// - Parameters:
    ///   - viewController:
    ///   - animated:
    internal  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.viewControllers.count>0){
            viewController.hidesBottomBarWhenPushed = true;
            //            if(viewController.isKind(of: NTESSessionViewController.self)){
            
            //            }else{
            viewController.createLeftBarBtnItem(Image: UIImage(named: "backLeft")!, method: nil);
            //            }
            
            //   viewController.navigationItem.leftBarButtonItem = self.leftItem;
            //            self.leftItem.tintColor = UIColor.white;
        }
        super.pushViewController(viewController, animated: false);
    }

}


// MARK: - 初始化UI
extension BaseNavigationController{
    
    /// 设置navigationBar样式
    fileprivate func setUpNavigationBarAppearance(){
        
        let navigationBarAppearance = UINavigationBar.appearance();
        let backgroundImage = UIColor.white.trans2Image();
        
        let shadow = NSShadow();
        shadow.shadowColor = UIColor.clear;
        //        shadow.shadowOffset = CGSize(width: 1, height: 0);
        var textAttributes = NSDictionary();
     
        textAttributes = [
            NSAttributedStringKey.foregroundColor :UIColor.white,
            NSAttributedStringKey.font:FONT(36),
            NSAttributedStringKey.shadow:shadow
        ];
        //        navigationBarAppearance.tintColor = UIColor.white
        navigationBarAppearance.tintColor = UIColor.white;
        navigationBarAppearance.setBackgroundImage(backgroundImage, for: .default);
        navigationBarAppearance.titleTextAttributes = textAttributes as? [NSAttributedStringKey : Any] ;
        
        navigationBarAppearance.shadowImage = UIColor.clear.trans2Image();
        // self.navigationController?.navigationBar.shadowImage = UIImage();
    }
    
    
    
}


