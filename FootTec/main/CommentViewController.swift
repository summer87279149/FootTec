//
//  CommentViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/23.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class CommentViewController: BaseUIViewController ,UITableViewDelegate,UITableViewDataSource {
    var cellArr:[MyCommentsList] = []
    var dataHasMore = true
    var page = 0
    var tableview:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的评价"
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func setupTableView(){
        self.tableview.backgroundColor = sViewColor
        self.tableview.scrollsToTop = true
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.isOpaque = false
        self.tableview.separatorColor = sNavColor
        self.tableview.tableFooterView = UIView()
        self.tableview.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight  = 200
        self.view.addSubview(tableview)
       setupRefresh(tableview: self.tableview)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as!CommentTableViewCell
        cell.backgroundColor = sViewColor
        cell.selectionStyle = .none
        cell.setCellData(model: cellArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CommentViewController {
    func setupRefresh(tableview:UITableView){
//        tableview.addHeader(withTarget: self, action: #selector(headerRefreshing))
//        tableview.headerBeginRefreshing()
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
        FootTecRequest.getMyComments(technician_id: uid, page: page, successResponse: {
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
                
            }
            guard let listArr = json.object(forKey: "list") as? NSArray else{
                self.loadFinished(tableview: self.tableview)
                return
            }
            for ele in listArr{
                let dic = ele as! NSDictionary
                let list = MyCommentsList.init(fromDictionary: dic)
                self.cellArr.append(list)
            }
            NSL("打印数组内容111\($0)")
            self.applyData(tableview: self.tableview)
            
        }, failure: {
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
