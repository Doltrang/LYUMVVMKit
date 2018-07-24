//
//  LYUPopWindowManager.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation


class LYUPopWindowManager: NSObject {
    
    
    ///  操作对象的manager
    static var shareManager:LYUPopWindowManager = {
        let manager = LYUPopWindowManager()
        return manager;
    }()
    
    /// 存储操作的对象
    fileprivate var operationQueue:OperationQueue = {
        let queue = OperationQueue()
        return queue;
    }()
    
    /// 显示弹窗
    func showPopView(popView:LYUBasePopWindow){
        let    semaphore = DispatchSemaphore(value: 0);
        let operation = BlockOperation {
            DispatchQueue.runThisInMainThread {
                guard let window =  UIApplication.shared.keyWindow else {
                    return;
                }
                window.addSubview(popView);
            }
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
           
        };
        
        if(LYUPopWindowManager.shareManager.operationQueue.operations.last != nil){
            /// 设置依赖
    operation.addDependency(LYUPopWindowManager.shareManager.operationQueue.operations.last!)
        }
        LYUPopWindowManager.shareManager.operationQueue.addOperation(operation);
        
        popView.dissmiss = {
                semaphore.signal();
        }
    }
    
}




class LYUBasePopWindow: UIView {
     var dissmiss:(()->(Void))?
     var show:(()->(Void))?
    
    var lab:UILabel = {
        let lab = UILabel()
        lab.backgroundColor = UIColor.red
        lab.textColor = UIColor.random();
        return lab;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lab);
        lab.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self);
            make.width.height.equalTo(100);
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event);
        if(self.dissmiss != nil){
            self.dissmiss!()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
