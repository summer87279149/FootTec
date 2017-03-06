//
//  LoginViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/24.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import KeyboardToolBar
import SwiftyJSON
class LoginViewController: BaseUIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    var account : String?
    var pwd : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登入"
        KeyboardToolBar.register(phoneNumber)
        KeyboardToolBar.register(passWord)
        getNoti()
    
    }
    func getNoti(){
        
        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RegisteOK"), object: nil, queue: nil, using: { (Notification) in
            self.dismiss(animated: true, completion: { 
                showHUDMessage("注册成功", to: self.view)
            })
        })

    }
 //登入按钮点击
    @IBAction func loginBtnClicked(_ sender: Any) {
        account = phoneNumber.text
        pwd = passWord.text
        //发起请求
        showHUDIn(view: self.view)
        FootTecRequest.loginWithPhoneNumber(account!,password:pwd!,successRes:{(res)->Void in
            hideHUDIn(view: self.view)
          let json =  JSON(res as! NSDictionary)
            NSL("JSON是\(json)")
            if let msg = json["msg"].string{
                showHUDMessage(msg, to: self.view)
                if json["status"].string == "success"{
                    UserModel.userID = json["info"]["id"].string
                    self.dismiss(animated: true, completion: nil)
                    var imgUrl = " "
                    var reallyName = "未知"
                    var worstate = "0"
                    var userInfo = "暂无自我介绍"
                    if let url = json["info"]["headimgurl"].string {
                        imgUrl = url
                                             }
                    if let name = json["info"]["name"].string {
                        reallyName = name
                        
                    }
                    if let workState = json["info"]["workstate"].string {
                        worstate = workState
                        
                    }
                    if let userinfo = json["info"]["info"].string {
                        userInfo = userinfo
                    }
                    UserModel.userStatus = worstate
                    UserModel.userImg = imgUrl
                    UserModel.userName = reallyName
                    UserModel.userTecInfo = userInfo
                    NSL("登入成功发送LoginSuccess通知")
                    if let alias = UserModel.userID{
                        NSL(alias)
                        JPUSHService.setTags(nil, alias: alias, fetchCompletionHandle: { NSL("设置极光推送的tags结果：\($0),\($1),\($2)") })
                    }
                    
                    let _ = NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoginSuccess"), object: nil, userInfo: ["imgUrl":imgUrl,"name":reallyName,"workstate":worstate])
                }
//                NSL("打印userid")
//                NSL(UserModel.userID)
//                NSL(UserDefaults.standard.value(forKey: "xt_user_id"))
//                let appde = AppDelegate()
//                UIApplication.shared.keyWindow?.rootViewController = appde.setupUI()
            }
        },fail:{(err)->Void in
            hideHUDIn(view: self.view)
            showHUDMessage("登入失败", to: self.view)
        })
    }
    
    
    //我要注册按钮点击
    @IBAction func registBtnClicke(_ sender: Any) {
        
        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: Bundle.main)
        let nav = BaseNavigationViewController(rootViewController: vc)
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(nav, animated: true, completion: nil)
    }
    //忘记密码 按钮点击
    @IBAction func forgetPwd(_ sender: Any) {
        let vc = ForgetPwdViewController(nibName: "ForgetPwdViewController", bundle: Bundle.main)
        let nav = BaseNavigationViewController(rootViewController: vc)
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
