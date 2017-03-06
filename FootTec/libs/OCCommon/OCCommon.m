//
//  OCCommon.m
//  FootTec
//
//  Created by Admin on 16/11/24.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "OCCommon.h"

@implementation OCCommon
-(BOOL)checkPassWord:(NSString *)password
{
    //6-20位数字和字母组成
    NSString *regex = @"^[a-zA-Z0-9]{6,16}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:password]) {
        return YES ;
    }else
        return NO;
}
@end
