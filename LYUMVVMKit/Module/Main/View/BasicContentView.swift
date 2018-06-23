//
//  BasicContentView.swift
//  KriFationClient
//
//  Created by qingxun on 2017/9/10.
//  Copyright © 2017年 吕陈强. All rights reserved.
//

import Foundation
import ESTabBarController_swift




class BasicContentView: ESTabBarItemContentView {

    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
    
        textColor = UIColor.white
        highlightTextColor = UIColor.blue
        
        
        iconColor = UIColor.blue
        highlightIconColor = UIColor.red
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
