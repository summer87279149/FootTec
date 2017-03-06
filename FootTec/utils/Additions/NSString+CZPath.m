//
//  NSString+CZPath.m
//
//  Created by yao wei on 16/6/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSString+CZPath.h"

@implementation NSString (CZPath)

- (NSString *)yw_appendDocumentDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)yw_appendCacheDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)yw_appendTempDir {
    NSString *dir = NSTemporaryDirectory();
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}







/** 银行卡号有效性问题Luhn算法
 254  *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 255  *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 256  *  16 位卡号校验位采用 Luhm 校验方法计算：
 257  *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 258  *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 259  *  3，将加法和加上校验位能被 10 整除。
 260  */
- (BOOL)bankCardluhmCheck{
    NSString * lastNum = [[self substringFromIndex:(self.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[self substringToIndex:(self.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    

NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
    [forwardDescArr addObject:forwardArr[i]];
}

NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组

for (int i=0; i< forwardDescArr.count; i++) {
    NSInteger num = [forwardDescArr[i] intValue];
    if (i%2) {//偶数位
        [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
    }else{//奇数位
        if (num * 2 < 9) {
        }else{
            NSInteger decadeNum = (num * 2) / 10;
            NSInteger unitNum = (num * 2) % 10;
            [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
            [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
        }
    }
}

__block  NSInteger sumOddNumTotal = 0;
[arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
    sumOddNumTotal += [obj integerValue];
}];

__block NSInteger sumOddNum2Total = 0;
[arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
    sumOddNum2Total += [obj integerValue];
}];

__block NSInteger sumEvenNumTotal =0 ;
[arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
    sumEvenNumTotal += [obj integerValue];
}];

NSInteger lastNumber = [lastNum integerValue];

NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;

return (luhmTotal%10 ==0)?YES:NO;
}


@end
