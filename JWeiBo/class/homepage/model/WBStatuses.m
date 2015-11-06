//
//  WBStatuses.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBStatuses.h"
#import "NSDate+jwl.h"
#import "MJExtension.h"
#import "WBphoto.h"

@implementation WBStatuses

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[WBphoto class]};
}

-(NSString *)created_at
{
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setLocale:local];
    fmt.dateFormat = @"EEE MM dd HH:mm:ss z yyyy";
    NSDate *createdTime = [fmt dateFromString:_created_at];
    
    //2.判断微博发送时间 和 现在时间 的差距
    if (createdTime.isToday) { //今天
        if(createdTime.deltaWithNow.hour >=1){
            return [NSString stringWithFormat:@"%ld小时前",createdTime.deltaWithNow.hour];
        }else if(createdTime.deltaWithNow.minute>=1)
        {
            return [NSString stringWithFormat:@"%ld分钟前",createdTime.deltaWithNow.minute];
        }else{
            return @"刚刚";
        }
    }else if(createdTime.isYesterday){ //昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdTime];
    }else if(createdTime.isYear){ //今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return  [fmt stringFromDate:createdTime];
    }else{ //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return  [fmt stringFromDate:createdTime];
    }
    
}

//<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
-(void)setSource:(NSString *)source
{
    //注意range初始化
    if (source.length != 0) {
        NSRange range = NSMakeRange(0, 0);
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        NSString *newsource = [source substringWithRange:range];
        _source = [NSString stringWithFormat:@"来自%@",newsource];
    }
}

//-(NSString *)source
//{
//    int loc = [_source rangeOfString:@">"].location + 1;
//    int length = [_source rangeOfString:@"</"].location - loc;
//    //_source = [source substringWithRange:NSMakeRange(loc, length)];
//      return [NSString stringWithFormat:@"来自%@",[_source substringWithRange:NSMakeRange(loc, length)]];
//    NSLog(@"%@",[NSString stringWithFormat:@"来自%@",[_source substringWithRange:NSMakeRange(loc, length)]]);
//}
@end

