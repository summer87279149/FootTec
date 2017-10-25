//
//  FootTecRequest.swift
//  FootTec
//
//  Created by Admin on 16/12/5.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

//服务类型
fileprivate let kServiceType = "http://xxj.yzszsf.com/technician.php/Index/category"
//上传身份证
fileprivate let kServiceUploadIdeCard = "http://xxj.yzszsf.com/technician.php/User/uploadIdCard"
//注册
fileprivate let kServiceRegister = "http://xxj.yzszsf.com/technician.php/User/register"
//发送验证码
fileprivate let vertifyCode = "http://xxj.yzszsf.com/index.php/Sms/send"
//登入
fileprivate let login = "http://xxj.yzszsf.com/technician.php/User/login"
//找回密码
fileprivate let findPassword = "http://xxj.yzszsf.com/technician.php/User/reset"
//我的接单
fileprivate let getMyOrder = "http://xxj.yzszsf.com/technician.php/Order"
//修改自我介绍（技师）
fileprivate let tecInfo = "http://xxj.yzszsf.com/technician.php/user/saveIntroduce"
//添加项目
fileprivate let addService = "http://xxj.yzszsf.com/technician.php/Project/addProject"
//添加项目照片
fileprivate let addServiceImages = "http://xxj.yzszsf.com/technician.php/Img/upImg"
//技师项目
fileprivate let tecServices = "http://xxj.yzszsf.com/technician.php/Project"
//删除项目
fileprivate let deleteService = "http://xxj.yzszsf.com/technician.php/Project/delProject"
//技师评论
fileprivate let myComments = "http://xxj.yzszsf.com/technician.php/Remark"
//我的已完成获取订单date为空
fileprivate let myCompleteOrder = "http://xxj.yzszsf.com/technician.php/Order"
//查询余额
fileprivate let myMoney = "http://xxj.yzszsf.com/technician.php/User/balance"
//提现
fileprivate let getCash = "http://xxj.yzszsf.com/technician.php/User/withdrawalsLog"
//上传个人头像
fileprivate let uploadTecPortraitImg = "http://xxj.yzszsf.com/technician.php/User/uploadIdCard"
//我的消息
fileprivate let myMessage = "http://xxj.yzszsf.com/technician.php/Remark/messsage"
//更改上班状态
fileprivate let changeState = "http://xxj.yzszsf.com/technician.php/User/switchStatus"
class FootTecRequest: NSObject {
    typealias success = (AnyObject)->()
    typealias failure = (Error)->()

    
    //获取注册页面的服务类型
    static  func getServiceType(success:@escaping success){
        RequestAPI.get(urlString: kServiceType, params: nil, complete: {(res:AnyObject) -> () in
            success(res)
        })
    }
    //上传身份证
    static func uploadCard(cardImage:UIImage,successResponse:@escaping success,failure:@escaping failure){
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyyMMddHHmmss"
        let str = dataFormatter.string(from: Date())
        let fileName = str+".jpg"
        XTRequestManager.post(kServiceUploadIdeCard, parameters: nil, responseSeializerType: .default, constructingBodyWith: {(fromdata:AFMultipartFormData?) -> Void in
            let dataOpt = UIImageJPEGRepresentation(cardImage, 0.1)
            guard let data = dataOpt else{
                NSL("获取订单date为空")
                return
            }
            fromdata?.appendPart(withFileData: data, name: "headimg", fileName: fileName, mimeType: "image/jpeg")
            
        }, success: {(response:Any) -> Void in
            successResponse(response as AnyObject)
            
        }, failure: {(err:Error?) -> Void in
            failure(err!)
        })
    }
    //注册
    static func register(account:String,password:String,name:String,cateid:String,area:String,address:String,verifyCode:String,work_years:String,card1:String,card2:String,successRes:@escaping success,fail:@escaping failure){
        //把用户输入的详细地址转换
        let encodeStr = address.addingPercentEncoding(withAllowedCharacters:.urlPathAllowed)
        let para = ["tel":account,
                    "password":password,
                    "name":name,
                    "cateid":cateid,
                    "area":area,
                    "address":encodeStr,
                    "verifyCode":verifyCode,
                    "work_years":work_years,
                    "idcard_img":"\(card1),\(card2)"
                    ]
        NSL("注册用户信息参数:\n \(para)")
        XTRequestManager.post(kServiceRegister, parameters: para, responseSeializerType: .default, success: {(response:Any) -> Void in
            
            successRes(response as AnyObject)
            NSL("注册成功打印")
            NSL(response)
        }, failure: {(err:Error?) -> Void in
            fail(err!)
            NSL("注册失败打印")
            NSL(err)
        })
        
    }
    //验证码
   static func requestVertifyCode(phoneNumber:String, success:@escaping success){
        let para = ["tel":phoneNumber]
        RequestAPI.get(urlString: vertifyCode, params: para, complete: {(res) -> () in
            success(res)
            NSL("FootTec里面发送验证码返回:\(res)")
        })
    }
   
    //登入
   static func loginWithPhoneNumber( _ phone:String, password:String, successRes:@escaping success, fail:@escaping failure)  {
        let para = ["tel":phone, "password":password]
        XTRequestManager.post(login, parameters: para, responseSeializerType: .default, success: {(response:Any) -> Void in
            
            successRes(response as AnyObject)
            
        }, failure: {(err:Error?) -> Void in
            fail(err!)
        })
    }
    //找回密码
    static func findMyPassword(phone:String,newPassword:String,vertifyCode:String, successRes:@escaping success,fail:@escaping failure){
        let para = ["tel":phone,"password":newPassword,"verifyCode":vertifyCode]
        XTRequestManager.post(findPassword, parameters: para, responseSeializerType: .default, success: {(res) -> Void in
            successRes(res as AnyObject)
        }, failure: {(err) -> Void in
            fail(err!)
        })
    }
    //我的接单
    static func getMyOrders(technician_id:String,style:String,page:Int,successRes:@escaping success,fail:@escaping failure){
        let pageNum = NSNumber(value: page)
        let para  = ["technician_id":technician_id,
                    "style":style,
                    "page":pageNum,
                    "status":"0"] as [String : Any]
        XTRequestManager.get(getMyOrder, parameters: para, responseSeializerType: .default, success: {(res) -> Void in
            successRes(res as AnyObject)
        }, failure: {(err) -> Void in
            fail(err!)
        })
        
        
    }
    //修改自我介绍
    static func setTecInfo(introduce:String,tecId:String,successRes:@escaping success,fail:@escaping failure){
        let para = ["introduce":introduce,"id":tecId]
        XTRequestManager.post(tecInfo, parameters: para, responseSeializerType: .default, success: {(res) -> Void in
            successRes(res as Any as AnyObject)
        }, failure: {(err) -> Void in
            fail(err!)
    })
    }
    //确认添加项目
    static func addServices(para:[String:String],successRes:@escaping success,fail:@escaping failure){
        XTRequestManager.post(addService, parameters: para, responseSeializerType: .default,success: {(res) -> Void in
            successRes(res as AnyObject)
        }, failure: {(err) -> Void in
            fail(err!)
        })
    }
    //上传项目照片
    static func uploadServiceImages(image:UIImage,successResponse:@escaping success,failure:@escaping failure){
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyyMMddHHmmss"
        let str = dataFormatter.string(from: Date())
        let fileName = str+".jpg"
        XTRequestManager.post(addServiceImages, parameters: nil, responseSeializerType: .default, constructingBodyWith: {(fromdata:AFMultipartFormData?) -> Void in
            let dataOpt = UIImageJPEGRepresentation(image, 0.1)
            guard let data = dataOpt else{
                return
            }
            fromdata?.appendPart(withFileData: data, name: "imgFile", fileName: fileName, mimeType: "image/jpeg")
            
        }, success: {(response:Any) -> Void in
            successResponse(response as AnyObject)
        }, failure: {(err:Error?) -> Void in
            failure(err!)
        })
    }
    //技师项目
    static func getTecServiceByTec(id:String?,successResponse:@escaping success,failure:@escaping failure){
        guard let id = id  else {
            return
        }
        XTRequestManager.get(tecServices, parameters: ["technician_id":id], responseSeializerType: .default, success: {
        successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }
        })
    }
   //删除项目
    static func deleteOneService(serviceID:String,TecID:String,successResponse:@escaping success,failure:@escaping failure){
        XTRequestManager.get(deleteService, parameters: ["pid":serviceID,"tech_id":TecID], responseSeializerType: .default, success: {
            successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }
        })
    }
    //技师评论
    static func getMyComments(technician_id:String?,page:Int,successResponse:@escaping success,failure:@escaping failure){
        guard let id = technician_id  else {
            return
        }
        let pageNum = NSNumber(value: page)
        let para  = ["technician_id":id,
                     "page":pageNum] as [String : Any]
        
        XTRequestManager.get(myComments, parameters: para, responseSeializerType: .default, success: {
        successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }
        })
    }
    //我的已完成订单
    static func getMyCompleteOrder(technician_id:String,style:String,page:Int,successResponse:@escaping success,failure:@escaping failure){
        let pageNum = NSNumber(value: page)
        let para = ["technician_id":technician_id,"style":style,"page":pageNum,"status":"1"]as [String : Any]
        NSL("已完成订单参数是\(para)")
        XTRequestManager.get(myCompleteOrder, parameters: para, responseSeializerType: .default, success: {
        successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }
        })
    }
    //查询余额
    static func getMyMoney(technician_id:String,successResponse:@escaping success,failure:@escaping failure){
        let para = ["technician_id":technician_id]
        XTRequestManager.get(myMoney, parameters: para, responseSeializerType: .default, success: {
            successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }
        })
    }
    //提现
    static func getMyCash(tech_id:String,money:String,account:String,method:String,content:String,successResponse:@escaping success,failure:@escaping failure){
        let para = [
            "tech_id":tech_id,
            "money":money,
            "account":account,
            "method":method,
            "content":" "
        ]
        XTRequestManager.post(getCash, parameters: para, responseSeializerType: .default, success: {
         successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }
        })
    }
    //上传头像
    static func uploadTecPortrait(image:UIImage,tech_id:String,successResponse:@escaping success,failure:@escaping failure){
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyyMMddHHmmss"
        let str = dataFormatter.string(from: Date())
        let fileName = str+".jpg"
        let para = ["dir":"uhead","id":tech_id
        ]
        XTRequestManager.post(uploadTecPortraitImg, parameters: para, responseSeializerType: .default, constructingBodyWith: {(fromdata:AFMultipartFormData?) -> Void in
            let dataOpt = UIImageJPEGRepresentation(image, 0.1)
            guard let data = dataOpt else{
                return
            }
            fromdata?.appendPart(withFileData: data, name: "headimg", fileName: fileName, mimeType: "image/jpeg")
            
        }, success: {
         successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }
        })
    }
    //我的消息
    static func getMyMessage(technician_id:String,page:Int,successResponse:@escaping success,failure:@escaping failure){
        let pageNum = NSNumber(value: page)
        let para = ["technician_id":technician_id,"page":pageNum] as [String : Any]
        XTRequestManager.get(myMessage, parameters: para, responseSeializerType: .default, success: {
            successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }

        })
    }
    //更改上班状态
    static func changeWorkState(technician_id:String,workState:String,lat:Double,lng:Double,successResponse:@escaping success,failure:@escaping failure){
        let latStr = String(lat)
        let lngStr = String(lng)
        let para = ["id":technician_id,
        "workstate":workState,"lat":latStr,"lng":lngStr]
        XTRequestManager.post(changeState, parameters: para, responseSeializerType: .default, success: {
            successResponse($0 as AnyObject)
        }, failure: {
            if let err = $0 {
                failure(err)
            }
        })
        
        
    }


}
