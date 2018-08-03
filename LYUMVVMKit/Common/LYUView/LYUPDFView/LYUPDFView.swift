//
//  LYUPDFView.swift
//  LYUMVVMKit
//
//  Created by 吕陈强 on 2018/8/2.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import CoreGraphics


class LYUPDFView: UIView {
    var document:CGPDFDocument!
    var pageNum:NSInteger = 1;
    
    /// 初始化加载pdf视图
    ///
    /// - Parameters:
    ///   - frame:frame
    ///   - document: CGPDFDocument
    ///   - pageNum: 页码
    init(frame: CGRect,document:CGPDFDocument,pageNum:NSInteger) {
        super.init(frame: frame);
        //        let pdfURL =   CFBundleCopyResourceURL(CFBundleGetMainBundle(), "Swift" as CFString, "pdf" as CFString, "" as CFString);
        //
        //        let  document = CGPDFDocument(pdfURL!);
        //        let totalPage = document!.numberOfPages;
        
        self.document = document;
        self.pageNum = pageNum;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawInContext(context: UIGraphicsGetCurrentContext()!);
    }
    
    
    func drawInContext(context:CGContext){
        
        //第一句是调整图形的位置，如不执行绘制的图形会不在视图可见范围内
        context.translateBy(x: 0.0, y: self.frame.size.height);
        //第二句的作用是使图形呈正立显示
        context.scaleBy(x: 1.0, y: -1.0);
        
        
        ////获取需要绘制的页码的数据。
        let pageRef:CGPDFPage = self.document!.page(at: self.pageNum)!;
        
        ////记录当前绘制环境，防止多次绘画
        context.saveGState();
        
        
        /*
         返回一个变换映射的盒子矩形作为指定的盒子
         通过交叉相关计算的正确有效的矩形和MediaBox页面的入口。
         
         旋转的有效直接根据网页/旋转进入。
         
         中心的矩形在`矩形”。如果“旋转”是非零的，那么
         
         rect将顺时针旋转`旋转度。`旋转”
         
         必须是90的倍数。
         
         大型的矩形，如果必要的话，那么，它与
         
         对`矩形边缘。如果` preserveaspectratio”是真的，那么最后
         
         直接将与边缘`矩形”只有在更多的限制性维度。
         */
        let pdfTransForm = pageRef.getDrawingTransform(CGPDFBox.cropBox, rect: self.bounds, rotate: 0, preserveAspectRatio: true);
        
        context.concatenate(pdfTransForm);//把创建的仿射变换参数和上下文环境联系起来
        context.drawPDFPage(pageRef);//把得到的指定页的PDF数据绘制到视图上
        context.restoreGState();
        
        
    }
}
