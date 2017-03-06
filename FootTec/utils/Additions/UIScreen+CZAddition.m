//
//  UIScreen+CZAddition.m
//
//  Created by yao wei on 16/5/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIScreen+CZAddition.h"

@implementation UIScreen (CZAddition)

+ (CGFloat)sm_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)sm_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)sm_scale {
    return [UIScreen mainScreen].scale;
}

@end
