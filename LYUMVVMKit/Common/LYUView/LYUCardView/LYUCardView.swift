//
//  LYUCardView.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/8/15.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit


class LYUCardView: UIView {

    fileprivate var collectionView:UICollectionView = {
        let layout = LYUCardViewLayout()
        
        let collectionV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout);
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        return collectionV;
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addSubview(self.collectionView);
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LYUCardView:UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath);
        cell.backgroundColor = UIColor.blue
        return cell;
    }
    
    
    
}
