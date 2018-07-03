//
//  LYUDynamicView.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/7/3.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class LYUDynamicView: UIView {

    //物理仿真 动画
 lazy fileprivate var _dynamicAnimator : UIDynamicAnimator =  {[weak self] in
    let ani = UIDynamicAnimator(referenceView: self!);
        return ani;
    }()
    
    //物理仿真 行为
    fileprivate var _dynamicItemBehavior:UIDynamicItemBehavior = {
        let beh = UIDynamicItemBehavior()
        //设置弹性系数,数值越大,弹力值越大 属性设置碰撞弹性系数。范围（0.0-1.0）
        beh.elasticity = 0.5;
        /// 属性设置行为中的dynamic item是否可以循环
        beh.allowsRotation = false;
        ///friction 属性设置摩擦系数
        beh.friction = 0;
        /// 设置线性阻力系数
        beh.resistance = 0;
        /// 设置相对密度
        beh.density = 1;
        return beh;
    }()
    
     //重力 行为
    fileprivate var _gravityBehavior:UIGravityBehavior = {
        let graB = UIGravityBehavior()
        graB.gravityDirection = CGVector(dx: 0, dy: -0.5);
        return graB;
    }()
    
    /////碰撞 行为
    fileprivate var _collisionBehavior:UICollisionBehavior = {
        let collB = UICollisionBehavior()
        collB.translatesReferenceBoundsIntoBoundary = true;
        collB.collisionMode = .everything;
        collB.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10));
        return collB;
    }()
    
    /// 推动行为
    fileprivate var _pushBehavior:UIPushBehavior = {
        let pushB = UIPushBehavior(items: [UIDynamicItem](), mode: .continuous);
        pushB.pushDirection =  CGVector(dx: 1, dy: 0);
        pushB.magnitude = 1;
        return pushB;
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBehavior();/// 初始化动画场景
        initViews();/// 初始化视图场景
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event);
        
        let v = self.viewWithTag(100) as! UIView;
       
         _pushBehavior.addItem(v)
         _dynamicAnimator.addBehavior(_pushBehavior);
        
    }
}


extension LYUDynamicView{
    
    fileprivate func initBehavior(){
        /// 添加物理仿真行为
        _dynamicAnimator.addBehavior(_dynamicItemBehavior)
        /// 添加重力行为
        _dynamicAnimator.addBehavior(_gravityBehavior);
        /// 添加碰撞行为
        _dynamicAnimator.addBehavior(_collisionBehavior);
        
       
    }
    
    
    
    fileprivate func initViews(){
        let tapView = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50));
        tapView.backgroundColor = UIColor.gray
        tapView.tag = 100;
        self.addSubview(tapView);
        _gravityBehavior.addItem(tapView);
        _collisionBehavior.addItem(tapView)
       
        
    }
}
