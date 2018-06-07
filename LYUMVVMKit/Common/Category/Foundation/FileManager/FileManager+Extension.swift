//
//  FileManager+Extension.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/25.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension FileManager
{
    ///  Returns path of documents directory
    public var documentsDirectoryPath: String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    /// Returns path of documents directory caches
    public var cachesDirectoryPath: String? {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}
