//
//  WBLockInfoView.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/17.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBLockInfoView.h"
#import "CoreLockConst.h"

@implementation WBLockInfoView


-(void)drawRect:(CGRect)rect{
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置属性
    CGContextSetLineWidth(ctx, CoreLockArcLineW);
    
    //设置线条颜色
    [CoreLockCircleLineNormalColor set];
    
    //新建路径
    CGMutablePathRef pathM =CGPathCreateMutable();
    
    CGFloat marginV = 3.f;
    CGFloat padding = 1.0f;
    CGFloat rectWH = (rect.size.width - marginV * 2 - padding*2) / 3;
    
    //添加圆形路径
    for (NSUInteger i=0; i<9; i++) {
        
        NSUInteger row = i % 3;
        NSUInteger col = i / 3;
        
        CGFloat rectX = (rectWH + marginV) * row + padding;
        
        CGFloat rectY = (rectWH + marginV) * col + padding;
        
        CGRect rect = CGRectMake(rectX, rectY, rectWH, rectWH);
        
        CGPathAddEllipseInRect(pathM, NULL, rect);
    }
    
    //添加路径
    CGContextAddPath(ctx, pathM);
    
    //绘制路径
    CGContextStrokePath(ctx);
    
    //释放路径
    CGPathRelease(pathM);
}

@end
