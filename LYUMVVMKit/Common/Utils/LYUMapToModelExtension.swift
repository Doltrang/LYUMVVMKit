//
//  LYUMapToModelExtension.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/25.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON


extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
}
extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
}

