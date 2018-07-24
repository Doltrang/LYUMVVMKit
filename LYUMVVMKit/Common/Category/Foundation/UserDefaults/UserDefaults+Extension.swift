//
//  UserDefaults+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/8.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
extension UserDefaults {
    
    public subscript(key: String) -> String {
        get {
            let value = object(forKey: key) as? String;
            return value ?? ""
        }
        set {
            set(newValue, forKey: key)
            UserDefaults.standard.synchronize()/// 快速写入
        }
    }
    
    public func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
}
