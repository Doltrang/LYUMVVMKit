//
//  HomeVC.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import NSObject_Rx
import Reusable
import Kingfisher

class HomeVC: BaseViewController {

    let viewModel = HomeViewModel()
    
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.white
        $0.register(cellType: HomeViewCell.self)
        $0.estimatedRowHeight = FIT_WIDTH(100)
        $0.rowHeight = UITableViewAutomaticDimension;
        
    }
    
    var vmOutput : HomeViewModel.Output?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        bindView()

        
    }


    
}

extension HomeVC
{
    fileprivate func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top);
        }
    }
    
    
    fileprivate func bindView() {
        let dataSource = RxTableViewSectionedReloadDataSource<HomeSection>(configureCell: { (_, tv, index, model) -> UITableViewCell in
            let cell : HomeViewCell = tv.dequeueReusableCell(for: index)
            cell.descLabel.text = model.desc
            cell.sourceLabel.text = "来源:" + model.source + "类别:" +  model.type;
            cell.imageV.kf.setImage(with: URL(string: model.url))
            
//               self.vmOutput?.sections
//             = cell.contentView.systemLayoutSizeFitting(CGSize(width: tableView.w, height: 0), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
            return cell
        })
        
        
        
        tableView.rx.modelSelected(HomeResult.self).subscribe { (event) in
            if(event.element != nil){
                LLog(event.element?.desc)
            }
            if(event.error != nil){
                LLog(event.error.debugDescription)
            }
            }.disposed(by: disposeBag);
        
        
//        tableView.rx.itemSelected.subscribe { (event) in
//            if(event.element != nil){
//                let index = event.element!;
//                let cell = self.tableView.cellForRow(at: index) as! HomeViewCell;
//                cell.imageV.snp.updateConstraints({ (make) in
//                    make.height.equalTo(FIT_WIDTH(600))
//            
//                })
//                
//                
//                LLog(cell)
//                self.tableView.reloadData();
//            }
//            }.disposed(by: disposeBag);
   
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        tableView.setupRefreshBlocking(refreshHeader: true, refreshFooter: true) { (type) in
            switch (type){
            case .loadNewData:
                self.vmOutput?.requestCommond.onNext(true)
                break;
            case .loadMoreData:
                self.vmOutput?.requestCommond.onNext(false)
                break;
            default :
                break;
            }
        };

        
        
        let vmInput = HomeViewModel.Input(category: .welfare)
        let vmOutput = viewModel.transform(input: vmInput)
        self.vmOutput = vmOutput;
        vmOutput.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        vmOutput.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
                 self?.tableView.mj_footer.endRefreshing()
            case .beingFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: rx.disposeBag)
        
         self.tableView.mj_header.beginRefreshing()
    }
}

extension HomeVC:UITableViewDelegate{
   
}
