//
//  HomeViewModel.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class HomeViewModel: BaseViewModel {
    // 存放着解析完成的模型数组
  fileprivate let models = BehaviorRelay<[HomeResult]>(value: [HomeResult]())
    // 记录当前的索引值
    var index: Int = 1
    
}

extension HomeViewModel:LYUViewModelType
{
    typealias Input = HomeViewModelInput
    typealias Output = HomeViewModelOutput
    
    struct HomeViewModelInput {
        let category:LYUHomeAPI.LYUHomeNetworkCategory
        init(category: LYUHomeAPI.LYUHomeNetworkCategory) {
            self.category = category;
        }
    }
    
    struct HomeViewModelOutput {
        // tableView的sections数据
        let sections: Driver<[HomeSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = BehaviorRelay<LYURefreshStatus>(value: .none)
        init(sections: Driver<[HomeSection]>) {
            self.sections = sections
        }
        
    }
    
    
    func transform(input: HomeViewModel.HomeViewModelInput) -> HomeViewModel.HomeViewModelOutput {
  
        let sections = models.asObservable().map { (models) -> [HomeSection] in
            // 当models的值被改变时会调用
            return [HomeSection(items: models)]
            }.asDriver(onErrorJustReturn: [])
        
        let output = HomeViewModelOutput(sections: sections)
        
        
        
        output.requestCommond.subscribe { (event) in
            if let isReloadData = event.element{
                self.index = isReloadData ? 1 : self.index+1;
             
                
//                LYUHomeNetworkService.requestHomdeList(apiInput: LYUHomeAPI.data(type: input.category, size: 20, index: self.index)).subscribe({ (event) in
//                    if(event.element != nil){
//                        LLog("请求成功")
//                        switch (event.element!){
//                        case .success(result: let response):
//                            let model =    response.mapModel(HomeM.self);
//                            LLog(model.results);
//                            break;
//                        default :
//                            break;
//                        }
//                    } 
//                }).disposed(by: disposeBag);
                
                
                LLog("入参:category:\(input.category)==index:\(self.index)")
                LYUHomeNetTool.rx.request(LYUHomeAPI.data(type: input.category, size: 20, index: self.index)).asObservable().mapModel(HomeM.self).subscribe(onNext: { (response) in
                    if(response.results.count > 0 ){
                        self.models.accept(isReloadData ? response.results : self.models.value + response.results)
                        output.refreshStatus.accept(isReloadData ? .endHeaderRefresh : .endFooterRefresh)
                    }else {
                        output.refreshStatus.accept(.noMoreData);
                    }
                }, onError: { (error) in
                    LLog(error);
                }, onCompleted: {
                    LLog("完成")
                }, onDisposed: nil).disposed(by: disposeBag)
                
                
    
            }else{
             
            }
            
            
            
            }.disposed(by: disposeBag);
        
   
     
        return output;
    }
}
