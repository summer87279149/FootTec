//
//  UserModel.swift
//  FootTec
//
//  Created by Admin on 16/12/6.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    private static let XT_USERID = "xt_user_id"
    private static let XT_USERNAME = "xt_user_name"
    private static let XT_USERIMG = "xt_user_images"
    private static let XT_USERPASSWORD = "xt_user_password"
    private static let XT_PHONENUMBER = "xt_user_phoneNumber"
    private static let XT_USERSTATUS = "xt_user_status"
    private static let XT_USERINFO = "xt_user_info"
    static let userdefaults = UserDefaults.standard
    static let sharedInstance = UserModel()
    private override init(){}

    static var userID:String? {
        get{
            return userdefaults.value(forKey: XT_USERID) as? String
        }
        set{
            userdefaults.set(newValue, forKey: XT_USERID)
            userdefaults.synchronize()
        }
        
        
    }
    static var userName:String?{
        get{
            return userdefaults.value(forKey: XT_USERNAME) as? String
        }
        set{
            userdefaults.set(newValue, forKey: XT_USERNAME)
            userdefaults.synchronize()
        }
    }
    
    static var userImg:String?{
        get{
            return userdefaults.value(forKey: XT_USERIMG) as? String
        }
        set{
            userdefaults.set(newValue, forKey: XT_USERIMG)
            userdefaults.synchronize()
        }
    }

    static var userPassword:String?{
        get{
            return userdefaults.value(forKey: XT_USERPASSWORD) as? String
        }
        set{
            userdefaults.set(newValue, forKey: XT_USERPASSWORD)
            userdefaults.synchronize()
        }
    }
    static var userStatus:String?{
        get{
            return userdefaults.value(forKey: XT_PHONENUMBER) as? String
        }
        set{
            userdefaults.set(newValue, forKey: XT_PHONENUMBER)
            userdefaults.synchronize()

        }
    }
    static var userPhoneNumber:String?{
        get{
            return userdefaults.value(forKey: XT_USERSTATUS) as? String
        }
        set{
            userdefaults.set(newValue, forKey: XT_USERSTATUS)
            userdefaults.synchronize()
            
        }
    }
    static var userTecInfo:String?{
        get{
            return userdefaults.value(forKey: XT_USERINFO) as? String
        }
        set{
            userdefaults.set(newValue, forKey: XT_USERINFO)
            userdefaults.synchronize()
            
        }
    }
    static func logOut(){
        userdefaults.set(nil, forKey: XT_USERSTATUS)
        userdefaults.set(nil, forKey: XT_PHONENUMBER)
        userdefaults.set(nil, forKey: XT_USERPASSWORD)
        userdefaults.set(nil, forKey: XT_USERIMG)
        userdefaults.set(nil, forKey: XT_USERNAME)
        userdefaults.set(nil, forKey: XT_USERID)
        userdefaults.synchronize()
    }
//    
//    private static func save(value:String,key:String){
//        userdefaults.set(value, forKey: key)
//        userdefaults.synchronize()
//    }
    
    
    
    
}
