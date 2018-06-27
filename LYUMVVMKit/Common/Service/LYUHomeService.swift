//
//  LYUHomeService.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import HandyJSON

class LYUHomeService {
    static let shareService:LYUHomeService = {
        let service = LYUHomeService()
        return service;
    }()
    
    
    func requestHomdeList<T: HandyJSON>(_ type: T.Type,apiInput:LYUHomeAPI) {
      
        LYUHomeNetTool.rx.request(apiInput).asObservable().mapModel(type).subscribe(onNext: { (response) in
            
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }, onDisposed: nil).disposed(by: disposeBag);
        
        
        
    }
    
    
    
}
