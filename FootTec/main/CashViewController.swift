//
//  CashViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class CashViewController: BaseUIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableview:UITableView = UITableView(frame: ktableViewFrames, style: .plain)
    var cellArr = ["支付宝提现","银行卡提现"]
    var cellImgArr = [UIImage.init(named: "支付宝"),UIImage.init(named: "银联"),UIImage.init(named: "person")]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择提现方式"
        setupTableView()
    }
    
    func setupTableView(){
        self.tableview.backgroundColor = sViewColor
        self.tableview.scrollsToTop = true
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.isOpaque = false
        self.tableview.separatorColor = sNavColor
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cashCell")
        self.tableview.tableFooterView = UIView()
        self.view.addSubview(tableview)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension CashViewController{
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cashCell", for: indexPath)
        cell.backgroundColor = sViewColor
        cell.selectionStyle = .none
        cell.textLabel?.text = cellArr[indexPath.row]
        cell.textLabel?.textColor = FootFontColor
        cell.imageView?.image = cellImgArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChooseCashViewController(nibName: "ChooseCashViewController", bundle: Bundle.main)
        
        switch indexPath.row {
        case 0:
            vc.cashType = .ZFB
        case 1:
            vc.cashType = .YH
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
