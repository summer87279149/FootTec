//
//  RegistInfoModel.swift
//  FootTec
//
//  Created by Admin on 16/11/25.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class RegistInfoModel {
    
    var phoneNumber : String?
    var password : String?
    var vertifyCode : String?
    var name : String?
    var workAge : String? = "0"
    var serviceType : String?
    var serviceTypeID : String?
    var serviceArea : String?
    var serviceAreaID : String?
    var serviceDetailAdd : String?
    //身份证正面
    var uploadImage1:UIImage?
    //身份证反面
    var uploadImage2:UIImage?
    //服务器返回的身份证正面地址
    var image1Url:String?
    //服务器返回的身份证反面地址
    var image2Url:String?
    //单例
        static let sharedInstance = RegistInfoModel()
        private init(){}
    func printAll() {
        NSL("调用model的print 参数:phoneNumber=\(phoneNumber),\n password=\(password),\n vertifyCode=\(vertifyCode),\n name＝\(name),\n workAge＝\(workAge),\n serviceType＝\(serviceType),\nserviceTypeID=\(serviceTypeID),\n serviceArea＝\(serviceArea),\n serviceAreaID＝\(serviceAreaID),\n serviceDetailAdd＝\(serviceDetailAdd)\n uploadImage1=\(uploadImage1)\n,uploadImage2=\(uploadImage2)\n image1Url=\(image1Url),image2Url=\(image2Url)")
    }
}

