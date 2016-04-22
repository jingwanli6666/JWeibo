//
//  WBToolbarButton.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-30.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBToolbarButton.h"
#import "WBStatuses.h"

@interface WBToolbarButton()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSMutableArray *dividers;
@property (nonatomic,weak)  UIButton *reweetedBtn;
@property (nonatomic,weak) UIButton *commentBtn;
@property (nonatomic,weak) UIButton *attitudeBtn;

@end

@implementation WBToolbarButton

-(NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

-(NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //1.设置
        self.opaque = NO;
        self.image = [UIImage resizeImageWithName:@"timeline_card_bottom_backgroud"];
    
        self.highlightedImage = [UIImage imageWithName:@"timeline_card_bottom_backgroud_highlighted"];
        self.userInteractionEnabled = YES;
        
        //2.设置button
        self.reweetedBtn.opaque = NO;
       self.reweetedBtn =  [self ToolBarWithTitle:@"转发" img:@"toolbar_icon_comment" bkgimage:@"timeline_card_leftbottom_highlighted"];
        
       self.commentBtn =  [self ToolBarWithTitle:@"评论" img:@"toolbar_icon_retweet" bkgimage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn = [self ToolBarWithTitle:@"赞" img:@"toolbar_icon_unlike" bkgimage:@"timeline_card_rightbottom_highlighted"];
        
        //3.设置分割线
        [self setupDivider];
        [self setupDivider];
        

    }
    return self;
}

/**
 *  <#Description#>
 *
 *  @param title    <#title description#>
 *  @param img      <#img description#>
 *  @param bkgimage <#bkgimage description#>
 */
-(UIButton *)ToolBarWithTitle:(NSString *)title img:(NSString *)img bkgimage:(NSString *)bkgimage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:img] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:bkgimage] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets =  UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

-(void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
    
}

/**
 *  <#Description#>
 */
-(void)layoutSubviews
{
    //CGFloat btnX = 0;
    [super layoutSubviews];
    
    CGFloat dividerW = 2;
    //1.设置按钮的frame
    CGFloat btnY = 0;
    CGFloat btnW = (self.frame.size.width-self.dividers.count*dividerW)/self.btns.count;
    CGFloat btnH = self.frame.size.height;
    
    for (int index =0; index < self.btns.count; index ++) {
        UIButton *btn = self.btns[index];
        CGFloat btnX = (btnW+dividerW)*index;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    //2.设置分割线
    CGFloat dividerH = btnH;
    
    CGFloat dividerY = 0;
    for (int i=0; i<self.dividers.count; i++) {
        UIImageView *divider = self.dividers[i];
        
        //设置frame
        UIButton *btn = self.btns[i];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
        }
    
}

-(void)setToolbarstatues:(WBStatuses *)toolbarstatues
{
    _toolbarstatues = toolbarstatues;
    
    [self setToolBarTitle:@"转发" count:toolbarstatues.reposts_count btn:self.reweetedBtn ];
    [self setToolBarTitle:@"评论" count:toolbarstatues.comments_count btn:self.commentBtn ];
    [self setToolBarTitle:@"赞" count:toolbarstatues.attitudes_count btn:self.attitudeBtn ];
}

-(void)setToolBarTitle:(NSString *)title count:(int)count btn:(UIButton *)btn
{
    NSString *str = nil;
    if (count) {
        if (count<10000) {
            str = [NSString stringWithFormat:@"%d",count];
            
        }else{
            
            double countdouble = count / 10000.0;
            str = [NSString stringWithFormat:@"%.1f万",countdouble];
            str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:str forState:UIControlStateNormal];
    }
   else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
