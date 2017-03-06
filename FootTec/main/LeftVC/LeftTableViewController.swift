//
//  LeftTableViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/22.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import SnapKit

let k_scale = UIScreen.sm_screenWidth()/320

class LeftTableViewController: BaseUIViewController,UITableViewDelegate,UITableViewDataSource {
    //上下班按钮
    var workBtn:UIButton?
    var photo :UIImageView?
    var phoneLabel:UILabel?
    var tableview:UITableView = UITableView(frame: kScreenBounds, style: .plain)
    lazy var cellArr = { ["已完成订单","服务设置","我的钱包", "我的消息","我的评价","个人设置","关于我们"]}()
    //数组的第一个vc创建方法与其他不一致
    lazy var VCArr = ["CompleteOrderViewController","MyServiceViewController","WalletViewController","MessageViewController","CommentViewController","SettingViewController","AboutUsViewController"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        //设置上下班
        setupGoToWork()
        addNotifiCations()
    }
    func addNotifiCations() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "protrait"), object: nil, queue: nil, using: {
            NSL("左侧视图接收到protrait通知:\($0)")
            if let imgUrl = $0.userInfo!["imgUrl"] as? String {
                /**在这里修改button 的image*/
                self.photo?.xt_setImage(urlString: imgUrl)
            }
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "logOut"), object: nil, queue: nil, using: {_ in
            NSL("左侧视图接收到logOut通知")
            self.photo?.xt_setImage(urlString: "")
            self.phoneLabel?.text = "未知用户"
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "LoginSuccess"), object: nil, queue: nil, using: {
            NSL("左侧视图接收到LoginSuccess通知")
            if let imgUrl = $0.userInfo!["imgUrl"] as? String {
                self.photo?.xt_setImage(urlString: imgUrl)
            }
            if let name = $0.userInfo!["name"] as? String {
                self.phoneLabel?.text = name
            }
            if let workstate  = $0.userInfo!["workstate"] as? String {
                if workstate == "0" {
                    self.workBtn?.setTitle("当前忙碌中..", for: .normal)
                }else{
                    self.workBtn?.setTitle("当前上班中..", for: .normal)
                }
            }

        })
    }

    func setupTableView(){
        self.tableview.backgroundColor = sViewColor
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.bounces = false
        self.tableview.isOpaque = false
        self.tableview.separatorColor = UIColor.clear
        self.tableview.showsVerticalScrollIndicator = false
        self.tableview.showsVerticalScrollIndicator = false
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "leftCells")
        self.tableview.tableHeaderView = setupHeadeerView()
        self.view.addSubview(tableview)
        
    }
    
    func setupHeadeerView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: k_scale*128))
        view.backgroundColor = UIColor.white
        
        let blackView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: k_scale*128))
        blackView.backgroundColor = sNavColor
        view.addSubview(blackView)
        
        self.photo = UIImageView.init(image: UIImage.init(named: "person.png"))
        self.photo?.layer.cornerRadius = 45;
        self.photo?.layer.masksToBounds = true;
        self.photo?.frame = CGRect(x: 150 - 22.5*k_scale, y: 20*k_scale, width: 90, height: 90)
        view.addSubview(self.photo!)
        if let img = UserModel.userImg {
            self.photo?.xt_setImage(urlString: img)
        }
        
        self.phoneLabel = UILabel.init(frame: CGRect(x: 150 - 70*k_scale, y: (self.photo?.frame)!.maxY, width: 140 * k_scale, height: 25))
        self.phoneLabel?.textColor = UIColor.white
        self.phoneLabel?.font = UIFont.systemFont(ofSize: 14)
//        self.phoneLabel?.text = "***********"
        self.phoneLabel?.textAlignment = .center
        if let name = UserModel.userName {
            self.phoneLabel?.text = name

        }
        view.addSubview(self.phoneLabel!)
        self.photo?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(20*k_scale)
            make.width.equalTo(90)
            make.height.equalTo(90)
        })
        self.phoneLabel?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalTo(self.photo!.snp.bottom).offset(3)
            ConstraintMaker.centerX.equalTo(self.photo!)
        })
        return view
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArr.count
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44*k_scale
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftCells", for: indexPath)
        cell.textLabel?.text = self.cellArr[indexPath.row]
        cell.backgroundColor = sViewColor
        cell.selectionStyle = .none
        let imageNameStr = "\(indexPath.row).png"
        cell.imageView?.image = sm_ImageName(imageNameStr)
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.menuViewController!.hideMenuViewController()
        let nav = appDelegate.menuViewController!.contentViewController as! BaseNavigationViewController
        if indexPath.row == 0 {
            let vc = customedSegmentViewController()
            vc.title = "已完成订单"
            nav.pushViewController(vc, animated: true)
        }else if indexPath.row == 1{
            let vc = MyServiceViewController(nibName: "MyServiceViewController", bundle: Bundle.main)
            nav.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc = WalletViewController(nibName: "WalletViewController", bundle: Bundle.main)
            nav.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            let vc = MessageViewController()
            nav.pushViewController(vc, animated: true)

        }else if indexPath.row == 4{
            let vc = CommentViewController()
            nav.pushViewController(vc, animated: true)
        }else if indexPath.row == 5{
            let vc = SettingViewController(nibName: "SettingViewController", bundle: Bundle.main)
            nav.pushViewController(vc, animated: true)
        }else if indexPath.row == 6{
            let vc = AboutUsViewController(nibName: "AboutUsViewController", bundle: Bundle.main)
            nav.pushViewController(vc, animated: true)
        }else{
            
        }
        
        
        
//        else{
//            let vc = NSClassFromString(Bundle.main.nameSpace + "." + self.VCArr[indexPath.row]) as! BaseUIViewController.Type
//            let vc2 = vc.init()
//            nav.pushViewController(vc2, animated: true)
//        }
    }
    
    fileprivate func customedSegmentViewController() -> CompleteViewController{
        let vc = CompleteViewController()
        return vc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension LeftTableViewController{
    func setupGoToWork(){
         workBtn = UIButton(type:.system)
        self.view.addSubview(workBtn!)
        workBtn?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.width.equalToSuperview().offset(-100)
            ConstraintMaker.height.equalTo(35)
            ConstraintMaker.bottom.equalToSuperview().offset(-20)
        })
        workBtn?.layer.cornerRadius = 5
        workBtn?.layer.borderColor = FootFontColor.cgColor
        workBtn?.layer.borderWidth = 1
        workBtn?.setTitle("当前忙碌中..", for: .normal)
        workBtn?.setTitleColor(FootFontColor, for: .normal)
        workBtn?.addTarget(self, action: #selector(workBtnClicked), for: .touchUpInside)
    }
    func workBtnClicked(_ btn:UIButton){
        var lat :Double = 0
        var lng :Double = 0
        CCLocationManager.shareLocation().getLocationCoordinate { (res) in
             lat = res.latitude
             lng = res.longitude
            NSL("经纬度是\(lat),\(lng)")
            if self.workBtn?.titleLabel?.text == "当前忙碌中.." {
                guard  let uid = UserModel.userID else {
                    return
                }
                //1表示上班
                showHUDIn(view: self.view)
                FootTecRequest.changeWorkState(technician_id: uid, workState: "0",lat:lat,lng:lng, successResponse: {
                    NSL("改变上班状态返回\($0["msg"] as! String)")
                    hideHUDIn(view: self.view)
                    self.workBtn?.setTitle("当前上班中..", for: .normal)
                    showHUDMessage("当前为上班状态(接单中)", to: self.view)
                }, failure: { _ in
                    showHUDMessage("请检查网络", to: self.view)
                })
                
            }
            if self.workBtn?.titleLabel?.text == "当前上班中.." {
                guard  let uid = UserModel.userID else {
                    return
                }
                //0表示下班
                showHUDIn(view: self.view)
                FootTecRequest.changeWorkState(technician_id: uid, workState: "1", lat:lat,lng:lng,successResponse: {
                    NSL("改变上班状态返回\($0["msg"] as? String)")
                    hideHUDIn(view: self.view)
                    self.workBtn?.setTitle("当前忙碌中..", for: .normal)
                    showHUDMessage("当前为忙碌状态(不接单)", to: self.view)
                }, failure: { _ in
                    showHUDMessage("请检查网络", to: self.view)
                })
            }
            
    
            
        }
        
       
    }
    
}
