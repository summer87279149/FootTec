   //
//  RegisterViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/24.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import KeyboardToolBar
import MBProgressHUD
class RegisterViewController: BaseUIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var passwordAgain: UITextField!
    
    @IBOutlet weak var checkNum: UITextField!
    //验证码按钮
    @IBOutlet weak var checkBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        KeyboardToolBar.register(phoneNumber)
        KeyboardToolBar.register(password)
        KeyboardToolBar.register(passwordAgain)
        KeyboardToolBar.register(checkNum)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", target: self, action: #selector(cancel))
        
    }
    func cancel(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
//发送验证码按钮点击
    @IBAction func checkBtnClicked(_ sender: Any) {
        
        if !checkPhoneNumber(str: phoneNumber.text!) {
            showHUDMessage("请输入正确格式的手机号码", to: self.view)
            return
        }
        FootTecRequest.requestVertifyCode(phoneNumber: phoneNumber.text!) {(res) in
            NSL("发送按钮点击后的返回\(res)")
            
//            showHUDMessage(res as! String, to: self.view)
        }
       self.checkBtn.startTime(withDuration: 30)
        
        
      
    }
    
    @IBAction func registeNext(_ sender: Any) {
        
        if checkInfo(){
            setData()
            let vc = RegisterSecondViewController(nibName: "RegisterSecondViewController", bundle: Bundle.main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
  
    
    @IBAction func agreeBtnClicked(_ sender: Any) {
        let vc = YinSiViewController(nibName: "YinSiViewController", bundle: Bundle.main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
   extension RegisterViewController{
    //设置手机号 密码 验证码
    func setData(){
        let model = RegistInfoModel.sharedInstance
        model.phoneNumber = phoneNumber.text
        model.password = password.text
        model.vertifyCode = checkNum.text
    }
    
    func checkInfo() -> Bool  {
        if !checkPhoneNumber(str: phoneNumber.text!) {
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
        if !(password.text == passwordAgain.text) {
            showHUDMessage("两次输入密码不一致", to: self.view)
            return false
        }
        if checkNum.text?.characters.count == 0{
            showHUDMessage("请输入正确的验证码", to: self.view)
            return false
        }
        return true
    }
   }
