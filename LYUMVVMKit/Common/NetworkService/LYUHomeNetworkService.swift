//
//  LYUHomeService.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import HandyJSON
import RxCocoa
import RxSwift



class LYUHomeNetworkService {
    
   class func requestHomdeList(apiInput:LYUHomeAPI) -> Observable<LYUResponseResult> {
        
        return LYUHomeNetTool.rx.request(apiInput).asObservable().map({ (response) in
            return LYUResponseResult.success(result: response)
        }).startWith(LYUResponseResult.loading(message: "正在加载中..."))
            .catchErrorJustReturn(LYUResponseResult.failure(info: NSError(domain: "", code: 500, userInfo: nil)));
    }
    
    
    
}
