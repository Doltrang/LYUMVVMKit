//
//  NSObject+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/4/2.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

extension NSObject
{
    // MARK:返回className
    var className:String{
        get{
          let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
        }
    }
   /** 获取成员变量，包括属性生成的成员变量 */
    var fetchIvarList:[String]{
        get{
            var ivar_arr = [String]();
            /// 获取并打印属性
            var ivar_count : UInt32 = 0;
            if let ivars = class_copyIvarList(type(of: self), &ivar_count){
              for i in 0..<ivar_count
              {
                let ivar = ivars[Int(i)];
                let ivarName = ivar_getName(ivar)
                let nName = String(cString: ivarName!)
                ivar_arr.append(nName);
                }
            }
            return  ivar_arr;
        }
    }
    
    /** 获取类的属性列表，包括私有和公有属性，也包括分类中的属性 */
    var fetchPropertyList:[String]{
        get{
            var p_arr = [String]();
            /// 获取并打印属性
            var p_count : UInt32 = 0;
            if let propertys = class_copyPropertyList(type(of: self), &p_count)
            {
                for i in 0..<p_count{
                    let p = propertys[Int(i)];
                    p_arr.append(String(cString:property_getName(p)));
                }
            }
            return p_arr;
        }
    }
    
/** 获取对象方法列表：包括getter, setter, 分类中的方法等 */
    var fetchInstanceMethodList:[String] {
        get{
            var m_count:UInt32 = 0;
            var m_methods_arr:[String] = [String]()
            if let methods = class_copyMethodList(type(of: self), &m_count){
                for i in 0..<m_count{
                    let m = methods[Int(i)];
                    let sel = method_getName(m);
//                    let name = sel_getName(sel);
                    m_methods_arr.append(NSStringFromSelector(sel));
                }
            }
            return m_methods_arr;
        }
    }
/** 获取协议列表 */
    var fetchProtocolList:[String] {
        get{
            var pro_count:UInt32 = 0;
            var pro_arr:[String] = [String]();
            if let protocolList = class_copyProtocolList(type(of: self), &pro_count){
                for i in 0..<pro_count{
                    let p = protocolList[Int(i)];
                    pro_arr.append(NSStringFromProtocol(p));
                }
            }
            return pro_arr;
        }
    }
    
    /// 对象的方法的交换
    ///
    ///   - originalSelector: 原始方法
    ///   - swizzledSelector: 交换方法
    class func swizzleMethod(originalSelector: Selector, swizzledSelector: Selector) {
        
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod!),
                                           method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(self,
                                originalSelector,
                                method_getImplementation(swizzledMethod!),
                                method_getTypeEncoding(swizzledMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
        
    }

}



