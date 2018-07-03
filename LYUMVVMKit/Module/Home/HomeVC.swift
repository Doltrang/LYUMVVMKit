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

class HomeVC: UIViewController {

    let viewModel = HomeViewModel()
    
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.white
        $0.register(cellType: HomeViewCell.self)
        $0.rowHeight = HomeViewCell.cellHeigh()
    }
    
    var vmOutput : HomeViewModel.Output?
    
    var url:String = ""
    var lastName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        bindView()
        
    }

     init(_ url:String, lastName:String){
 
        self.url = url
        self.lastName = lastName
         super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

extension HomeVC
{
    fileprivate func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20);
        }
    }
    
    
    fileprivate func bindView() {
        let dataSource = RxTableViewSectionedReloadDataSource<HomeSection>(configureCell: { (_, tv, index, model) -> UITableViewCell in
            let cell : HomeViewCell = tv.dequeueReusableCell(for: index)
            cell.descLabel.text = model.desc
            cell.sourceLabel.text = "来源:" + model.source + "类别:" +  model.type;
            cell.imageV.kf.setImage(with: URL(string: model.url))
            return cell
        })
        
        
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.vmOutput?.requestCommond.onNext(true)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.vmOutput?.requestCommond.onNext(false)
        })
        
        
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

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
