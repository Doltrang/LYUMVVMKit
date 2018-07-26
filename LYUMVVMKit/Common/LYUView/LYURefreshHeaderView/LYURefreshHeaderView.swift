//
//  LYURefreshHeaderView.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/26.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import MJRefresh

class LYURefreshHeaderView: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
        self.mj_h = FIT_WIDTH(41);
    }
}
