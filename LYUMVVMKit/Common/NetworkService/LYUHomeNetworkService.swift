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
    static let shareService:LYUHomeNetworkService = {
        let service = LYUHomeNetworkService()
        return service;
    }()
    
    
//    func requestHomdeList<T: HandyJSON>(_ type: T.Type,apiInput:LYUHomeAPI) -> Observable<LYUResponseResult> {
//        
//        LYUHomeNetTool.rx.request(apiInput).asObservable().mapModel(type).subscribe(onNext: { (response) in
//           
//        }, onError: { (error) in
//            
//        }, onCompleted: {
//            
//        }, onDisposed: nil).disposed(by: disposeBag);
//
//        return 
//    }
    
    
    
}
