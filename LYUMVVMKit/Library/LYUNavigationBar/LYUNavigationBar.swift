//
//  LYUNavigationBar.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/8/5.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
class LYUNavigationBar: UIView {
    
    var barNavBgView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v;
    }()
    
    var barNavBgImageView:UIImageView = {
        let imgV = UIImageView()
        return imgV;
    }()
    
    var titleView:UIView = {
        let v = UIView()
        return v;
    }()
    
    var titleLab:UILabel = {
        let lab = UILabel()
        return lab;
    }()
    
    
    
}
