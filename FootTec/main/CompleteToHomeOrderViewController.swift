//
//  CompleteToHomeOrderViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/23.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class CompleteToHomeOrderViewController: BaseUIViewController ,UITableViewDelegate,UITableViewDataSource{
    var cellArr:[CompleteOrderModelList] = []
    var dataHasMore = true
    var page = 0
    var tableview:UITableView = UITableView(frame: ktableViewFrames, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView(){
        self.tableview.backgroundColor = sViewColor
        self.tableview.scrollsToTop = true
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.isOpaque = false
        self.tableview.separatorColor = sNavColor
        self.tableview.tableFooterView = UIView()
        self.tableview.register(UINib.init(nibName: "CompleteTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CompleteCell")
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight  = 200
        self.view.addSubview(tableview)
        setupRefresh(tableview: self.tableview)
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CompleteCell", for: indexPath) as! CompleteTableViewCell
        cell.backgroundColor = sViewColor
        cell.selectionStyle = .none
        cell.setCellData(model: cellArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension CompleteToHomeOrderViewController{
    
    func setupRefresh(tableview:UITableView){
        tableview.addHeader(withTarget: self, action: #selector(headerRefreshing))
        tableview.headerBeginRefreshing()
        tableview.addFooter(withTarget: self, action: #selector(footerRefreshing))
    }
    func headerRefreshing(){
        requestData(isHeader: true)
    }
    func footerRefreshing(){
        if self.dataHasMore {
            requestData(isHeader: false)
        }else{
            loadFinished(tableview: tableview)
        }
    }
    func loadFinished(tableview:UITableView){
        tableview.headerEndRefreshing()
        tableview.footerEndRefreshing()
        
    }
    func requestData(isHeader:Bool){
        if isHeader {
            page = 1
            dataHasMore = true
        }else{
            page = page+1
        }
        
        guard let uid = UserModel.userID else{
            let vc = LoginViewController(nibName: "LoginViewController", bundle: Bundle.main)
            self.present(vc, animated: true, completion: nil)
            self.loadFinished(tableview: self.tableview)
            NSL("userID为空")
            return
        }
        FootTecRequest.getMyCompleteOrder(technician_id: uid, style: "1", page: page, successResponse: {
            if isHeader {
                self.cellArr.removeAll()
            }
            NSL("已完成上门订单返回是\($0)")
            if  let json = $0 as? NSDictionary {
                if let dic = json.object(forKey: "page") as? NSDictionary {
                    let nextpage = dic["next_page"]
                    NSL("next_page是\(nextpage)")
                    if String(describing: nextpage!) == "0"{
                        self.dataHasMore = false
                    }
                }
                guard let ll = json.object(forKey: "list") as? NSArray else{
                    self.loadFinished(tableview: self.tableview)
                    return
                }
                for ele in ll{
                    if let dic = ele as? NSDictionary{
                        let list = CompleteOrderModelList.init(fromDictionary: dic)
                        self.cellArr.append(list)
                    }
                }
                NSL("打印数组内容\($0)")
                self.applyData(tableview: self.tableview)
            }
        }, failure: {(res)->Void in
        })
        
    }
    func applyData(tableview:UITableView){
        tableview.reloadData()
        loadFinished(tableview: tableview)
    }
    
}
