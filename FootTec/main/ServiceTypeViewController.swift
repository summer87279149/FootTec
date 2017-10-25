//
//  ServiceTypeViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/25.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
class ServiceTypeViewController: BaseUIViewController,UITableViewDelegate,UITableViewDataSource{
    var block : ((NSDictionary) -> (Void))?
    var cellArr :[NSDictionary] = []
    var tableview:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择服务类型"
        setupTableView()
    }

}
extension ServiceTypeViewController{
    
    func setupTableView(){
        self.tableview.backgroundColor = sViewColor
        self.tableview.scrollsToTop = true
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.isOpaque = false
        self.tableview.separatorColor = sNavColor
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "ServiceTypecell")
//        self.tableview.rowHeight = UITableViewAutomaticDimension
//        self.tableview.estimatedRowHeight  = 200
        self.view.addSubview(tableview)
        requestServiceType()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "ServiceTypecell", for: indexPath)
        let dic = cellArr[indexPath.row] as NSDictionary
        cell.textLabel?.text = dic.object(forKey: "catename") as! String?
        cell.textLabel?.textColor = FootFontColor
        cell.accessoryType = .none
        cell.backgroundColor = sViewColor
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic = cellArr[indexPath.row]
        block!(dic)
        self.navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
//网络请求
extension ServiceTypeViewController{
    func requestServiceType() {
        //      MBProgressHUD.showAdded(to: self.view, animated: true)
        FootTecRequest.getServiceType(){[unowned self]
            response in
            let arr = response as! NSArray
            for var dic in arr{
                self.cellArr.append(dic as! NSDictionary)
            }
            DispatchQueue.main.async(execute: {
                self.tableview.reloadData()
            })
        }
    }
}
