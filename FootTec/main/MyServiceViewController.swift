//
//  MyServiceViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/25.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class MyServiceViewController: BaseUIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var textview: UITextView!
    //自我介绍
    @IBOutlet weak var introSelfLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var characterCounts: UILabel!
    
    var cellArr :[MyServicesList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "服务设置"
        if let userinfo = UserModel.userTecInfo {
             self.textview.text = userinfo
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", fontSize: 16.0, target: self, action:#selector(tijiao), isBack: false)
        setupTableView()
    }
    func tijiao()  {
        textview.endEditing(true)
        let userid = UserModel.userID!
        showHUDIn(view: self.view)
        FootTecRequest.setTecInfo(introduce: textview.text, tecId: userid, successRes: { (res) in
            UserModel.userTecInfo = self.textview.text
            hideHUDIn(view: self.view)
            showHUDMessage(res["msg"] as! String, to: self.view)
        NSL("提交个人信息返回\(res)")
        
        }, fail: {(err ) in
            hideHUDIn(view: self.view)
            showHUDMessage("修改失败，请检查网络", to: self.view)
        })
        
        
    }
    //添加项目
    @IBAction func addProject(_ sender: Any) {
        let vc = AddServiceViewController(nibName: "AddServiceViewController", bundle: Bundle.main)
        let nav = BaseNavigationViewController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textview.endEditing(true)
    }
    func setupTableView(){
        self.textview.delegate = self
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.scrollsToTop = true
        self.tableview.separatorColor = sNavColor
        self.tableview.tableFooterView = UIView()
        self.tableview.register(UINib.init(nibName: "MyServiceTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CompleteCell")
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight  = 200
//        DispatchQueue.main.async(execute: {
//            self.tableview.reloadData()
//        })
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        let model = cellArr[indexPath.row]
        guard let userID = UserModel.userID else {
            return
        }
         showHUDIn(view: self.view)
        FootTecRequest.deleteOneService(serviceID: model.pid, TecID: userID, successResponse: {
            NSL("删除成功:\($0)")
            if let result:String = $0["status"] as?String,result == "success" {
                self.cellArr.remove(at: indexPath.row)
                self.tableview.deleteRows(at: [indexPath], with: .fade)
            }
            
            hideHUDIn(view: self.view)
        }, failure: {
            hideHUDIn(view: self.view)
            NSL("删除出错:\($0)")
        })
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CompleteCell", for: indexPath) as! MyServiceTableViewCell
        cell.backgroundColor = sViewColor
        cell.selectionStyle = .none
        cell.setCellData(model: cellArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showHUDIn(view: self.view)
        FootTecRequest.getTecServiceByTec(id: UserModel.userID, successResponse: {
            self.cellArr.removeAll()
            if let json  = $0 as? NSDictionary{
                NSL("服务设置请求回调\(json)")
                if let arr:[NSDictionary] = json["list"] as? [NSDictionary]{
                    for dic:NSDictionary in arr{
                      self.cellArr.append(MyServicesList(fromDictionary: dic))
                    }
                    hideHUDIn(view: self.view)
                    DispatchQueue.main.async(execute: {
//                        self.setupTableView()
                        self.tableview.reloadData()
                    })
                }
            }
        }, failure: { (err) -> Void in
            hideHUDIn(view: self.view)
            showHUDMessage("请检查网络", to: self.view)
        })
    }

}
extension MyServiceViewController:UITextViewDelegate{
    var count : Int{
        return 120 - textview.text.characters.count
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.introSelfLabel.isHidden = true
    }
    func textViewDidChange(_ textView: UITextView) {
        
        characterCounts.text = "还可以输入\(count)字符"
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location>120{
            return false
        }else{
            return true
        }
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        textview.resignFirstResponder()
        return false
    }
}
