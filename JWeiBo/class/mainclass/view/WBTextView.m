//
//  WBTextView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-11.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBTextView.h"

@implementation WBTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 通知 UITextViewTextDidChangeNotification
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}



/**
 *  监听文字改变
 */
-(void)textDidChange
{
    //重绘(重新调用)
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.hasText)  return;
    
    //文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholdColor?self.placeholdColor:[UIColor grayColor];
    //画文字
    
    CGFloat placeholdX = 5;
    CGFloat placeholdY = 8;
    CGFloat placeholdW = rect.size.width - 2 * placeholdX;
    CGFloat placeholdH = rect.size.height - 2 * placeholdX;
    CGRect placeholdRect = CGRectMake(placeholdX, placeholdY, placeholdW, placeholdH);
    [self.placehold drawInRect:placeholdRect withAttributes:attrs];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setPlacehold:(NSString *)placehold
{
    _placehold = [placehold copy];
    [self setNeedsDisplay];
}

-(void)setPlaceholdColor:(UIColor *)placeholdColor
{
    _placeholdColor = [placeholdColor copy];
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}



@end
