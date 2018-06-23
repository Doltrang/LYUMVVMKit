//
//  LYUViewModelType.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

protocol LYUViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
