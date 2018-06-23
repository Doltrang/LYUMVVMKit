//
//  LYUMainVC.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import ESTabBarController_swift
class LYUMainVC: ESTabBarController {
    
    ///  titles of tabbar
      let titles = ["首页","视野","消息","我的"]
    // selected images of tabbar
    let selectedImages:[UIImage] = [#imageLiteral(resourceName: "tabbar_homepageHL"),#imageLiteral(resourceName: "tabbar_projectHL"),#imageLiteral(resourceName: "tabbar_contactsHL"),#imageLiteral(resourceName: "tabbar_mineHL")]
    // unselected images of tabbar
    let unselectedImages:[UIImage] = [#imageLiteral(resourceName: "tabbar_homepage"),#imageLiteral(resourceName: "tabbar_project"),#imageLiteral(resourceName: "tabbar_contacts"),#imageLiteral(resourceName: "tabbar_mine")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        loadMainVC();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.view.frame = UIScreen.main.bounds;
    }
    
}

extension LYUMainVC{
    
    fileprivate func loadMainVC(){
        if let tabBar = self.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .centered
        }
        
        //首页
        let homepage = BaseNavigationController(rootViewController: HomeVC());
        homepage.tabBarItem = ESTabBarItem.init(title: "首页", image: self.unselectedImages[0], selectedImage: self.selectedImages[0], tag: 0);
        
        
        //
        let video =  BaseNavigationController(rootViewController:VideoVC());
        video.tabBarItem = ESTabBarItem.init(title: "视频", image: self.unselectedImages[1], selectedImage: self.selectedImages[1], tag: 1);
        
        //消息
        let message =  BaseNavigationController(rootViewController:MessageVC());
        message.tabBarItem = ESTabBarItem.init(title: "消息", image: self.unselectedImages[2], selectedImage: self.selectedImages[2], tag: 2);
        
        
        
        
        //我的
        let mine =   BaseNavigationController(rootViewController:MineVC());
        mine.tabBarItem = ESTabBarItem.init(title: "我的", image: self.unselectedImages[3], selectedImage: self.selectedImages[3], tag: 3);
        
        //添加到控制器
        self.viewControllers = [homepage,video,message,message,mine];

        
        self.shouldHijackHandler = {(tabbarController,viewController,index) in
            
            //清除自定义消息
            viewController.tabBarItem.badgeValue = nil
            
            if index == 2{
                return false
            }
            return false;
            
        };
        
        
        self.didHijackHandler = { (tabbarController,viewController,index) in
            
            LLog("处理点击事件")
            
            
        }
        
        
    }
    
}
