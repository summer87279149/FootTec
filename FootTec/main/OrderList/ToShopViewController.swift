

import UIKit

class ToShopViewController: BaseUIViewController ,UITableViewDataSource,UITableViewDelegate{
    var cellArr:[ToShopModelList] = []
    var dataHasMore = true
    var page = 0
    var headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
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
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.showsVerticalScrollIndicator = false
        self.tableview.showsVerticalScrollIndicator = false
        self.tableview.register(UINib.init(nibName: "ToShopTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ToShopCell")
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight  = 200
        self.view.addSubview(tableview)
        
        setupRefresh(tableview: self.tableview)
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ToShopCell", for: indexPath) as! ToShopTableViewCell
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
extension ToShopViewController{
    func setupRefresh(tableview:UITableView){
        tableview.addHeader(withTarget: self, action: #selector(headerRefreshing))
        tableview.headerBeginRefreshing()
        tableview.addFooter(withTarget: self, action: #selector(footerRefreshing))
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "LoginSuccess"), object: nil, queue: nil, using: {_ in
            self.tableview.headerBeginRefreshing()
        })
    }
    func headerRefreshing(){
        requestData(isHeader: true)
    }
    func footerRefreshing(){
        if self.dataHasMore  {
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

        FootTecRequest.getMyOrders(technician_id: uid, style: "0", page: page, successRes: { [unowned self] (res)->Void in
            if isHeader {
                self.cellArr.removeAll()
            }
            let json = res as! NSDictionary
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
                let dic = ele as! NSDictionary
                let list = ToShopModelList.init(fromDictionary: dic)
                self.cellArr.append(list)
            }
            NSL("打印数组内容\(res)")
            self.applyData(tableview: self.tableview)
            }, fail: {(res)->Void in
                 
        })
    }
    func applyData(tableview:UITableView){
        tableview.reloadData()
        loadFinished(tableview: tableview)
    }

}
