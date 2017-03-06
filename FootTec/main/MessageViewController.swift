//
//  MessageViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/22.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class MessageViewController: BaseUIViewController  ,UITableViewDelegate,UITableViewDataSource{
    var cellArr:[MessageModelList] = []
    var dataHasMore = true
    var page = 0
    var tableview:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的消息"
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
        self.tableview.register(UINib.init(nibName: "MessageCell", bundle: Bundle.main), forCellReuseIdentifier: "MessageCelll")
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight  = 200
        self.view.addSubview(tableview)
         setupRefresh(tableview: self.tableview)
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "MessageCelll", for: indexPath) as! MessageCell
        cell.backgroundColor = sViewColor
        cell.selectionStyle = .none
        cell.setCellData(model: cellArr[indexPath.row])
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension MessageViewController{
    
    func setupRefresh(tableview:UITableView){
//                tableview.addHeader(withTarget: self, action: #selector(headerRefreshing))
//                tableview.headerBeginRefreshing()
        requestData(isHeader: true)
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
            return
        }
        FootTecRequest.getMyMessage(technician_id: uid, page: page, successResponse: {
            if isHeader {
                self.cellArr.removeAll()
            }
            let json = $0 as! NSDictionary
            if let dic = json.object(forKey: "page") as? NSDictionary {
                let nextpage = dic["next_page"]
                NSL("next_page是\(nextpage)")
                
                if String(describing: nextpage!) == "0"{
                    self.dataHasMore = false
                }
                guard let listArr = json.object(forKey: "list") as? NSArray else{
                    self.loadFinished(tableview: self.tableview)
                    return
                }
                for ele in listArr{
                    let dic = ele as! NSDictionary
                    let list = MessageModelList.init(fromDictionary: dic)
                    self.cellArr.append(list)
                }
                NSL("打印数组内容111\($0)")
                self.applyData(tableview: self.tableview)
            }
        }
            ,failure: {
                    NSL($0)
            })
    }
    func applyData(tableview:UITableView){
        DispatchQueue.main.async {
            tableview.reloadData()
        }
        loadFinished(tableview: tableview)
    }

}
