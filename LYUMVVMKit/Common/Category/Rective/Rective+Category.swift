//
//  Rective+Category.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/3.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation


import UIKit
import RxSwift
import RxCocoa

//扩展UILabel
extension Reactive where Base: UILabel {
    //让验证结果（ValidationResult类型）可以绑定到label上
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}
