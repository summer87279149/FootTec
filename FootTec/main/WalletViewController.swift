//
//  WalletViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/22.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class WalletViewController: BaseUIViewController {

    @IBOutlet weak var MyScrollView: UIScrollView!
    
    @IBOutlet weak var moneyBtn: UIButton!
    
    @IBOutlet weak var clauseBtn: UIButton!
    //余额
    @IBOutlet weak var balanceLabel: UILabel!
    //用户名
    @IBOutlet weak var userName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "余额"
        requestData()
    }
    func requestData()  {
        guard let tec_id = UserModel.userID else {
            return
        }
        showHUDIn(view: self.view)
        FootTecRequest.getMyMoney(technician_id: tec_id, successResponse: {
            if  let json = $0 as? NSDictionary,let yu_e = json["money"] as? String ,let name = json["name"] as? String {
               self.balanceLabel.text = yu_e+"元"
            self.userName.text = "用户名:"+name
                hideHUDIn(view: self.view)
                
            }
        NSL("打印我的余额:\($0)")
        }, failure: {
        NSL("查询余额失败\($0)")
            hideHUDIn(view: self.view)
            showHUDMessage("请检查网络连接", to: self.view)
        })
    }
    //取钱按钮点击
    @IBAction func getMoney(_ sender: UIButton) {
        self.navigationController?.pushViewController(CashViewController(), animated: true)
    }

    //查看条款
    @IBAction func clauseBtnClicked(_ sender: UIButton) {
        navigationController?.pushViewController(AboutUsViewController(), animated: true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
