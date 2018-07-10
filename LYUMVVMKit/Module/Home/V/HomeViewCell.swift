//
//  HomeViewCell.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/6/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit
import Reusable

class HomeViewCell: UITableViewCell,Reusable {

    var imageV:UIImageView = {
        let img = UIImageView();
        return img;
    }()
    
    var descLabel:UILabel = {
         let lab = UILabel()
        lab.font = FONT(24);
        lab.textColor = UIColor.blue
        return lab;
    }()
    
    var sourceLabel:UILabel = {
        let lab = UILabel()
        lab.font = FONT(30)
        lab.textColor = UIColor.gray
        return lab;
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI();
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeViewCell{
    
    fileprivate func setupUI(){
        self.contentView.addSubview(self.imageV);
        self.contentView.addSubview(self.descLabel);
        self.contentView.addSubview(self.sourceLabel);
        
        self.imageV.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(self.contentView.snp.left);
            make.top.equalTo(self.contentView.snp.top);
            make.width.equalTo(FIT_WIDTH(300));
            make.height.equalTo(FIT_WIDTH(300))
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-FIT_WIDTH(20)).priority(100)
        }
        
        self.descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageV.snp.right).offset(FIT_WIDTH(20))
            make.width.lessThanOrEqualTo(FIT_WIDTH(300));
            make.height.equalTo(FIT_WIDTH(40));
            make.top.equalTo(self.imageV.snp.top);
        }

        self.sourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.descLabel)
            make.width.equalTo(FIT_WIDTH(300))
            make.height.lessThanOrEqualTo(FIT_WIDTH(200))
            make.top.equalTo(self.descLabel.snp.bottom).offset(FIT_WIDTH(40))
        }
        
    
    }
}
extension HomeViewCell {
    static func cellHeigh() -> CGFloat {
        return FIT_WIDTH(260)
    }
}
