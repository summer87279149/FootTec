//
//  Common.swift
//  FootTec
//
//  Created by Admin on 16/11/22.
//  Copyright © 2016年 Admin. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Kingfisher
func showHUDIn(view:UIView){
    MBProgressHUD.showAdded(to: view, animated: true)
}
//显示文字1秒
func showHUDMessage(_ message:String, to view:UIView)  {
    let HUD = MBProgressHUD.showAdded(to: view, animated: true)
    HUD.mode = .text
    HUD.label.text = message
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
       hideHUDIn(view: view)
    }
}

func hideHUDIn(view:UIView)  {
   MBProgressHUD.hide(for: view, animated: true)
    
}
//MARK - 字体
/// 系统普通字体
var sm_FontSize: (CGFloat) -> UIFont = {size in
    return UIFont.systemFont(ofSize: size);
}

/// 系统加粗字体
var sm_BoldFontSize: (CGFloat) -> UIFont = {size in
    return UIFont.boldSystemFont(ofSize: size);
}

/// 仅用于标题栏上，大标题字号
let sNavFont = sm_FontSize(18);

/// 标题字号
let sTitleFont = sm_FontSize(18);

/// 正文字号
let sBodyFont = sm_FontSize(16);

/// 辅助字号
let sAssistFont = sm_FontSize(14);


//MARK - 颜色
/// 根据RGBA生成颜色(格式为：22,22,22,0.5)
var sm_RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}

/// 根据RGB生成颜色(格式为：22,22,22)
var sm_RGBColor: (CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1);
}
//导航栏背景色
let sNavColor = sm_RGBColor(145, 132, 110)
//view背景色
let sViewColor = sm_RGBColor(195, 180, 153)
let sClearColor = UIColor.clear
let cellBG = sm_RGBColor(181,164,138)
let FootFontColor = sm_RGBColor(59,41,53)
// MARK: - 打印日志

/**
 打印日志
 
 - parameter message: 日志消息内容
 */
 func NSL<T>(_ message: T)
{
    #if DEBUG
        print(" \(message)");
    #endif
}

// MARK: - 线程队列

/// 主线程队列
let sMainThread = DispatchQueue.main;
/// Global队列
let sGlobalThread = DispatchQueue.global(qos: .default)

// MARK: - 系统版本

/// 获取系统版本号
let sSystemVersion = Float(UIDevice.current.systemVersion);
/// 是否IOS7系统
let sIsIOS7OrLater = Int(UIDevice.current.systemVersion)! >= 7 ? true : false;
/// 是否IOS8系统
let sIsIOS8OrLater = Int(UIDevice.current.systemVersion)! >= 8 ? true : false;
/// 是否IOS9系统
let sIsIOS9OrLater = Int(UIDevice.current.systemVersion)! >= 9 ? true : false;

// MARK: - 常用宽高
let ktableViewFrames = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-100)
/// 屏幕Bounds
let kScreenBounds = UIScreen.main.bounds;
/// 屏幕高度
let kScreenHeight = UIScreen.main.bounds.size.height;
/// 屏幕宽度
let kScreenWidth = UIScreen.main.bounds.size.width;
/// 导航栏高度
let sNavBarHeight = 44.0;
/// 状态栏高度
let sStatusBarHeight = 20.0;
/// Tab栏高度
let sTabBarHeight = 49.0;

//根据图片名称获取图片
let sm_ImageName: (String) -> UIImage? = {imageName in
    return UIImage(named: imageName);
}


func kIsEmpty(string: String) -> Bool {
    if string.isEmpty || string == "" {
        return true
    }else {
        return false
    }
}
func checkPhoneNumber(str:String)->Bool {
    let pattern = "1[3578]\\d{9}"
    
    let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
    let res = regex.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, str.characters.count))
    if res.count > 0 {
        return true
    }
    return false
}
extension UIImageView{
   open func xt_setImage(urlString:String){
        let url = URL(string: urlString)
        self.kf.setImage(with: url)
    }
}
