//
//  ServiceAreaViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/25.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class ServiceAreaViewController: BaseUIViewController,UITableViewDelegate,UITableViewDataSource {
    var block:((String)->Void)?
    var path : String{
        return Bundle.main.path(forResource: "CityData", ofType: "plist")!
    }
    var tableview:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
    
    var sectionArr:Array<Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let areaArr = NSArray(contentsOfFile: path)
        sectionArr = areaArr?.map({ dic -> String in
           let a = dic as! NSDictionary
            return a.object(forKey: "initial") as! String
        })
        NSL("数组里面是:\(sectionArr)")
        
        self.navigationItem.title = "选择服务地区"
        setupTableView()
    }
    
    
    
    func setupTableView(){
        self.tableview.backgroundColor = sViewColor
        self.tableview.scrollsToTop = true
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.isOpaque = false
        self.tableview.separatorColor = sNavColor
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "ServiceAreaViewCell")
//        self.tableview.register(UINib.init(nibName: "MessageCell", bundle: Bundle.main), forCellReuseIdentifier: "MessageCelll")
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight  = 200
        self.view.addSubview(tableview)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "ServiceAreaViewCell", for: indexPath)
        cell.backgroundColor = sViewColor
        cell.selectionStyle = .none
        return cell
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
