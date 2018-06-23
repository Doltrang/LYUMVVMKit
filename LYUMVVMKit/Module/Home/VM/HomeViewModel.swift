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
    let models = Variable<[HomeM]>([])
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
        let refreshStatus = Variable<LYURefreshStatus>(.none)
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
                LYUHomeNetTool.rx.request(LYUHomeAPI.data(type: input.category, size: 20, index: self.index)).mapJSON().subscribe(onSuccess: { (response) in
                    LLog(response);
                }, onError: { (error) in
                    LLog(error);
                }).disposed(by: disposeBag)
    
            }else{
                
            }
            
            
            
            }.disposed(by: disposeBag);
        
        
     
        return output;
    }
}
