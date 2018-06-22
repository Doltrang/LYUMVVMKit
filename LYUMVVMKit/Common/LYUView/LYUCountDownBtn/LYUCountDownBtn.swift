//
//  LYUCountDownBtn.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/5/25.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

typealias DidChangeBlock = (LYUCountDownBtn,NSInteger) -> (String)
typealias DidFinishedBlock = (LYUCountDownBtn,NSInteger) -> (String)
typealias TouchedDownBlock = (LYUCountDownBtn,NSInteger) -> ()


class LYUCountDownBtn: UIButton {
    fileprivate var _second:NSInteger = 0;
    fileprivate var _totalSecond:NSInteger = 0;
    fileprivate var _timer:Timer?
    fileprivate var _didChangeBlock:DidChangeBlock?
    fileprivate var _didFinishedBlock:DidFinishedBlock?
    fileprivate var _touchedDownBlock:TouchedDownBlock?
    
    /// 添加点击事件
    func addToucheHandler(touchHandler:@escaping TouchedDownBlock){
        self._touchedDownBlock = touchHandler;
        self.addTarget(self, action: #selector(touchevent(btn:)), for: .touchUpInside);
    }
    
    /// 回调触发的事件
    func didChangeHandler(didChangeHandler:@escaping DidChangeBlock){
        self._didChangeBlock =  didChangeHandler;
    }
    
    /// 回调结束的事件
    func didFinishedHandler(didFinishedHandler:@escaping DidFinishedBlock){
        self._didFinishedBlock = didFinishedHandler;
    }
    
   /// 开始计时
    func startCountDown(totalSecond:NSInteger){
        _totalSecond = totalSecond;
        _second = totalSecond;
        self._timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerStart(theTimer:)), userInfo: nil, repeats: true);
        RunLoop.current.add(self._timer!, forMode: .commonModes);
    }
    
    /// 停止计时
    func stopCountDown(){
        if(self._timer != nil){
            self._timer!.invalidate();
            self._timer = nil;
            _second = _totalSecond;
            if(self._didFinishedBlock != nil){
                self.setTitle(self._didFinishedBlock!(self,_totalSecond), for: .normal);
            }else{
                self.setTitle("重新获取", for: .normal);
            }
        }
    }
    @objc fileprivate func  touchevent(btn:LYUCountDownBtn){
        if(self._touchedDownBlock != nil){
            self._touchedDownBlock!(btn,btn.tag);
        }
    }
    
    @objc fileprivate func timerStart(theTimer:Timer){
        if(_second == 1){ /// 停止计时
            self.stopCountDown();
        }else{
            _second -= 1;
            if(self._didChangeBlock != nil){
                self.setTitle(self._didChangeBlock!(self,_second), for: .normal)
            }else{
                setTitle("\(_second)秒后重新获取", for: .normal);
            }
        }
    }
    
    deinit {
        self._timer = nil;
    }
    
    
    
    
    

}
