//
//  ChooseCashViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON
enum CashType {
    case ZFB
    case YH
}
class ChooseCashViewController: BaseUIViewController {
    
    
    var cashType:CashType?
    @IBOutlet weak var accoutLabel: UILabel!
    @IBOutlet weak var account: UITextField!
    
    @IBOutlet weak var money: UITextField!
    
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        switch cashType! {

        case .ZFB:
            self.title = "支付宝提现"
            self.accoutLabel.text = "支付宝帐号:"
        case .YH:
            self.title = "银行卡取现"
            self.accoutLabel.text = "银行卡号:"
        }
    }

    @IBAction func BtnClicked(_ sender: Any) {
        if !check() {
            return
        }
      let alert =  UIAlertController(title: "确认您的信息", message: "您的取现账户是:\(account.text!)， 提现金额是:\(money.text!)，收款人是:\(name.text!)", preferredStyle: .alert)
        let action = UIAlertAction(title: "取消", style: .default, handler: {
            _ in
            _ = self.navigationController?.popViewController(animated: true)
        })
        let action2 = UIAlertAction(title: "确定", style: .default, handler: {
            _ in
//            showHUDMessage("执行网络请求", to: self.view)
            self.getMyCash()
        })
        alert.addAction(action)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
        
    }
    func getMyCash(){
        guard let uid = UserModel.userID else{
            showHUDMessage("请退出重新登入", to: self.view)
//            self.present(LoginViewController(), animated: true, completion: nil)
            return
        }
        var payType = ""
        switch cashType! {
        case .ZFB:
            payType = "支付宝"
        default:
            payType = "银行卡"
        }
        showHUDIn(view: self.view)
        FootTecRequest.getMyCash(tech_id: uid, money: money.text!, account: account.text!, method: payType, content: " ", successResponse: {
            hideHUDIn(view: self.view)
            NSL("提现结果\($0["msg"] as! String)")
            if  let title = $0 as? NSDictionary {
                guard let msg  = title["msg"] as? String else{
                    return
                }
                if let titleStr = title["status"] as? String{
                    if titleStr == "success"{
                       let alert = UIAlertController(title: "请求已成功提交", message: msg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "好的", style: .default, handler: {
                            _ in
                            _ = self.navigationController?.popToRootViewController(animated: true)
                        })
                         alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        let alert = UIAlertController(title: "操作失败", message: msg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "取消", style: .default, handler: {
                            _ in
                            _ = self.navigationController?.popToRootViewController(animated: true)
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
            }
            
        }, failure: {_ in 
            hideHUDIn(view: self.view)
            showHUDMessage("操作失败，请检查网络", to: self.view)
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        account.endEditing(true)
        money.endEditing(true)
        name.endEditing(true)
    }
    
    
    func  check() -> Bool{
        if account.text?.characters.count == 0{
            showHUDMessage("请输入正确的收款账号", to: self.view)
            return false
        }
        if name.text?.characters.count == 0{
            showHUDMessage("请输入正确的收款人姓名", to: self.view)
            return false
        }
        
        if UserTool.validateNumber(money.text){
            if Int(money.text!) != nil{
                return true
            }
            showHUDMessage("请输入正确的整数金额", to: self.view)
            return false
        }else{
            showHUDMessage("请输入正确的整数金额", to: self.view)
            return false
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
