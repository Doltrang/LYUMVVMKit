//
//  LYUHomeAPI.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//



import Foundation
import Moya
import RxCocoa
import RxSwift


enum LYUHomeAPI {
 
    enum LYUHomeNetworkCategory: String {
        case all     = "all"
        case android = "Android"
        case ios     = "iOS"
        case welfare = "福利"
    }
    
       case data(type: LYUHomeNetworkCategory, size:Int, index:Int)
}

extension LYUHomeAPI:TargetType
{
  
    var baseURL: URL{
         return URL.init(string: "http://gank.io/api/data/")!
    }
    
    var path: String {
            switch self {
            case .data(let type, let size, let index):
            return "\(type.rawValue)/\(size)/\(index)"
            }
    }
    
    var method: Moya.Method {
         return .get
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var headers: [String : String]? {
        return nil;
    }
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    
    //MARK:task type
    var task: Task {
        return .requestPlain
    }
    
    var validate: Bool {
        return false
    }

}

let LYUHomeNetTool = MoyaProvider<LYUHomeAPI>()
