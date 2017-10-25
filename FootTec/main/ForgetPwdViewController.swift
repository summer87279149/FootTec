//
//  ForgetPwdViewController.swift
//  FootTec
//
//  Created by Admin on 16/12/1.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import KeyboardToolBar
class ForgetPwdViewController: BaseUIViewController {

    @IBOutlet weak var vCodeBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var vertifyCode: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        KeyboardToolBar.register(vertifyCode)
        KeyboardToolBar.register(password)
        KeyboardToolBar.register(phone)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", target: self, action: #selector(cancel))
    }
    
    func cancel(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //发送验证码
    @IBAction func vCodeBtnClicked(_ sender: Any) {
        if !checkPhoneNumber(str: phone.text!) {
            showHUDMessage("请输入正确格式的手机号码", to: self.view)
            return
        }
        vCodeBtn.startTime(withDuration: 30)
        FootTecRequest.requestVertifyCode(phoneNumber: phone.text!) { (res) in
            NSL("找回密码界面发送按钮点击后的返回\(res)")
        }
        
    }
    
    //确定找回密码
    @IBAction func findBtnClicked(_ sender: Any) {
        let bool = checkInfo()
        if bool{
            showHUDIn(view: self.view)
           FootTecRequest.findMyPassword(phone: phone.text!, newPassword: password.text!, vertifyCode: vertifyCode.text!, successRes: { (res) in
            hideHUDIn(view: self.view)
            if let msg = res["msg"] as? String {
                showHUDMessage(msg, to: self.view)
            }
            
            NSL(res)
           }, fail: { (err) in
            hideHUDIn(view: self.view)
           })
        }
        
    }

    
    func checkInfo() -> Bool  {
        if !checkPhoneNumber(str: phone.text!) {
            showHUDMessage("请输入正确格式的手机号码", to: self.view)
            return false
        }
        if (password.text?.characters.count)!<6 {
            showHUDMessage("密码至少6位", to: self.view)
            return false
        }
        if (password.text?.characters.count)!>15 {
            showHUDMessage("密码至多16位", to: self.view)
            return false
        }
        let ocCommon = OCCommon()
        let isValidPhoneNumber = ocCommon.checkPassWord(password.text)
        if !isValidPhoneNumber {
            showHUDMessage("密码应仅为数字和字母", to: self.view)
            return false
        }
        
        if vertifyCode.text?.characters.count == 0{
            showHUDMessage("请输入正确的6位验证码", to: self.view)
            return false
        }
        return true
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

 

}
