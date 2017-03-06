//
//  UserTool.h
//  
//
//  Created by admin on 15/12/4.
//  Copyright © 2015年 hackcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserTool : NSObject
//银行卡号
- (BOOL) checkCardNo:(NSString*) cardNo;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//匹配邮箱
+ (BOOL) validateEmail:(NSString *)email;
//正则判断  0或者非0开头的数字 
+ (BOOL)validateNumber:(NSString *) textString;
// 匹配手机号
+ (BOOL) isValidateMobile:(NSString *)mobile;

// 显示提示框
+ (void)alertViewDisplayTitle:(NSString *)title andMessage:(NSString *)message andDisplayValue:(double)value;
// md5加密
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

@end
