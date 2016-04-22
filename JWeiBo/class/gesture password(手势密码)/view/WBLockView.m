//
//  WBLockView.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/13.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBLockView.h"
#import "WBLockItemView.h"
#import "CoreLockConst.h"

const CGFloat marginValue = 36.0f;

@interface WBLockView()

/** 装itemView的可变数组**/
@property (nonatomic,strong) NSMutableArray *itemViews;

/** 临时密码记录器 **/
@property (nonatomic,copy) NSMutableString *pwd;

/** 设置密码：第一次设置的正确的密码 */
@property (nonatomic,copy) NSString *firstRightPWD;

/** 修改密码过程中的验证旧密码正确 */
@property (nonatomic,assign) BOOL modify_VeriryOldRight;

@end

@implementation WBLockView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //解锁视图准备
        [self lockViewPrepare];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //解锁视图准备
        [self lockViewPrepare];
    }
    
    return self;
}

/**
 *  绘制线条
 *
 *  @param rect <#rect description#>
 */
-(void)drawRect:(CGRect)rect
{
    if (_itemViews == nil || _itemViews.count == 0) return;
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加路径
    CGContextAddRect(ctx, rect);
    
    //添加圆形路径
    [_itemViews enumerateObjectsUsingBlock:^(WBLockItemView *itemView, NSUInteger idx, BOOL *stop) {
        CGContextAddEllipseInRect(ctx, itemView.frame);
    }];
    
    //剪裁
    CGContextEOClip(ctx);
    
    //新建路径：管理线条
    CGMutablePathRef pathM = CGPathCreateMutable();
    
    //设置上下文属性
    //1.设置线条颜色
    [CoreLockLockLineColor set];
    
    //线条转角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    //设置线宽
    CGContextSetLineWidth(ctx, 1.0f);
    
    [_itemViews enumerateObjectsUsingBlock:^(WBLockItemView  *itemView, NSUInteger idx, BOOL * stop) {
        CGPoint directPoint = itemView.center;
        
        if (idx == 0) { //第一个
            //添加起点
            CGPathMoveToPoint(pathM, NULL, directPoint.x, directPoint.y);
        }else{ //其他
            
            //添加路径线条
            CGPathAddLineToPoint(pathM, NULL, directPoint.x, directPoint.y);
        }
    }];
    
    //将路径添加到上下文
    CGContextAddPath(ctx, pathM);
    
    //渲染路径
    CGContextStrokePath(ctx);
    
    //释放路径
    CGPathRelease(pathM);
}

/**
 *  解锁视图准备
 */
-(void)lockViewPrepare{
    for (NSUInteger i = 0; i < 9; i++) {
        WBLockItemView *itemView = [[WBLockItemView alloc] init];
        [self addSubview:itemView];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemViewWH = (self.frame.size.width - 4 * marginValue)/3.0f;
    
    [self.subviews enumerateObjectsUsingBlock:^(WBLockItemView * itemView, NSUInteger idx, BOOL * stop) {
        NSUInteger row = idx % 3;
        NSUInteger col = idx / 3;
        
        CGFloat x = marginValue * (row +1) + row * itemViewWH;
        
        CGFloat y = marginValue * (col + 1) + col * itemViewWH;
        
        CGRect frame  = CGRectMake(x, y, itemViewWH, itemViewWH);
        
        //设置tag
        itemView.tag = idx;
        
        itemView.frame = frame;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //解锁处理
    [self lockHandle:touches];
    
    if(LockTypeSetPwd == _type){ //设置密码
        if (self.firstRightPWD == nil) { //第一次输入
            if(_setPWBeginBlock != nil)
            {
                _setPWBeginBlock();
            }else{ //确认
                if (_setPWConfirmlock != nil) {
                    _setPWConfirmlock();
                }
                
            }
        }
    }else if (LockTypeVeryfiPwd == _type) { //验证密码
                //开始
                if (_verifyPWBeginBlock != nil) {
                    _verifyPWBeginBlock();
                }
        
    }else if(CoreLockTypeModifyPwd == _type){
                //开始
                if (_modifyPwdBlock != nil) {
                    _modifyPwdBlock();
                }
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //解锁处理
    [self lockHandle:touches];
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //手势结束
    [self gestureEnd];
}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //手势结束
    [self gestureEnd];
}

-(void)gestureEnd
{
    //设置密码检查
    if (self.pwd.length != 0) {
        [self setPwdCheck];
    }
    
    for (WBLockItemView *itemView in self.itemViews) {
        itemView.selected = NO;
        
        //清空方向
        itemView.direct = 0;
    }
    
    //清空数组所有对象
    [self.itemViews removeAllObjects];
    
    //再绘制
    [self setNeedsDisplay];
    
    //清空密码
    self.pwd = nil;
}


-(void)setPwdCheck
{
    NSUInteger count = self.itemViews.count;
    
    if (count < CoreLockMinItemCount) {
        if (_setPWErrorLengthTooShortBlock != nil) {
            _setPWErrorLengthTooShortBlock(count);
        }
        return;
    }
    
    if (LockTypeSetPwd == _type) { //设置密码
        [self setupPwd];
    }else if(LockTypeVeryfiPwd == _type){
        if (_verifyPwdBlock != nil) {
            _verifyPwdBlock(self.pwd);
        }
    }else if(CoreLockTypeModifyPwd == _type){
        if (!_modify_VeriryOldRight) {
            if (_verifyPwdBlock != nil) {
                _modify_VeriryOldRight = _verifyPwdBlock(self.pwd);
            }
        }
        else{
            //设置密码
            [self setupPwd];
        }
        
    }
}

/**
 *  设置密码
 */
-(void)setupPwd{
    
    //密码合法
    if (self.firstRightPWD == nil) { //第一次设置密码
        self.firstRightPWD = self.pwd;
        if (_setPWFirstRightBlock!=nil) {
            _setPWFirstRightBlock();
        }
    }else{
        if (![self.firstRightPWD isEqualToString:self.pwd]) { //两次密码不一致
            if (_setPWErrorTwiceDiffBlock!=nil) {
                _setPWErrorTwiceDiffBlock(self.firstRightPWD,self.pwd);
            }
            return;
        }else{ //再次密码输入一致
            if (_setPWTwiceSameBlock!=nil) {
                _setPWTwiceSameBlock(self.firstRightPWD);
            }
        }
    }
    
}

/**
 *  解锁处理
 *
 *  @param touches <#touches description#>
 */
-(void)lockHandle:(NSSet *)touches{
    //取出触摸点
    UITouch *touch = [touches anyObject];
    
    CGPoint loc = [touch locationInView:self];
    
    WBLockItemView *itemView = [self itemViewWithTouchLocation:loc];
    
    //如果为空，返回
    if (itemView == nil) {
        return;
    }
    
    //如果已经存在，返回
    if([self.itemViews containsObject:itemView]) return;
    
    //添加
    [self.itemViews addObject:itemView];
    
    //记录密码
    [self.pwd appendFormat:@"%@",@(itemView.tag)];
    
    //计算方向：每添加一次itemView就计算一次
    [self calDirect];
    
    //item处理
    [self itemHandel:itemView];
}

/**
 *  计算方向：每添加一次itemView就计算一次
 */
-(void)calDirect{
    
    NSUInteger count = _itemViews.count;
    
    if (_itemViews == nil || count <= 1) {
        return;
    }
    
    //取出最后一个对象
    WBLockItemView *last_first_itemView = _itemViews.lastObject;
    
    //倒数第二个
    WBLockItemView *last_second_itemView = _itemViews[count - 2];
    
    //计算倒数第二个的位置
    CGFloat last_first_x = last_first_itemView.frame.origin.x;
    CGFloat last_first_y = last_first_itemView.frame.origin.y;
    CGFloat last_second_x = last_second_itemView.frame.origin.x;
    CGFloat last_second_y = last_second_itemView.frame.origin.y;
    
    //倒数第一个itemView相对倒数第二个itemView来说
    //正上
    if (last_first_x == last_second_x && last_second_y > last_first_y) {
        last_second_itemView.direct = LockItemViewDirecTop;
    }
    
    //正左
    if(last_second_y == last_first_y && last_second_x > last_first_x) {
        last_second_itemView.direct = LockItemViewDirecLeft;
    }
    
    //正下
    if(last_second_x == last_first_x && last_second_y < last_first_y) {
        last_second_itemView.direct = LockItemViewDirecBottom;
    }
    
    //正右
    if(last_second_y == last_first_y && last_second_x < last_first_x) {
        last_second_itemView.direct = LockItemViewDirecRight;
    }
    
    //左上
    if(last_second_x > last_first_x && last_second_y > last_first_y) {
        last_second_itemView.direct = LockItemViewDirecLeftTop;
    }
    
    //右上
    if(last_second_x < last_first_x && last_second_y > last_first_y) {
        last_second_itemView.direct = LockItemViewDirecRightTop;
    }
    
    //左下
    if(last_second_x > last_first_x && last_second_y < last_first_y) {
        last_second_itemView.direct = LockItemViewDirecLeftBottom;
    }
    
    //右下
    if(last_second_x < last_first_x && last_second_y < last_first_y) {
        last_second_itemView.direct = LockItemViewDiretRightBottom;
    }

}

/**
 *  item处理
 *
 *  @param itemView <#itemView description#>
 */
-(void)itemHandel:(WBLockItemView *)itemView
{
    //选中
    itemView.selected = YES;
    
    //绘制
    [self setNeedsDisplay];
}

/**
 *  返回触摸点所在itemView
 *
 *  @param loc 触摸点
 *
 *  @return WBLockItemView
 */
-(WBLockItemView *)itemViewWithTouchLocation:(CGPoint)loc
{
    WBLockItemView *itemView = nil;
    
    for (WBLockItemView *itemViewSub in self.subviews) {
        if (!CGRectContainsPoint(itemViewSub.frame, loc)) continue;
        itemView = itemViewSub;
        break;
            
        }
    return itemView;
}

#pragma mark - 懒加载 getter和setter方法
-(NSMutableArray *)itemViews
{
    if (_itemViews == nil) {
        _itemViews = [NSMutableArray array];
    }
    return _itemViews;
}

-(NSMutableString *)pwd
{
    if (_pwd == nil) {
        _pwd = [NSMutableString string];
    }
    return _pwd;
}


@end

