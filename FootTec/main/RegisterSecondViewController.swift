//
//  RegisterSecondViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/25.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import KeyboardToolBar
class RegisterSecondViewController: BaseUIViewController {

    var cityID : String?
    @IBOutlet weak var name: UITextField!
    //工作年限
    @IBOutlet weak var workAges: UITextField!
    //详细地址
    @IBOutlet weak var detailAddress: UITextField!
        
    @IBOutlet weak var serviceTypeLabel: UILabel!
    
    @IBOutlet weak var serviceAreaLabel: UILabel!
    
    var serviceTypeID:String = "-1"
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardToolBar.register(name)
        KeyboardToolBar.register(workAges)
        KeyboardToolBar.register(detailAddress)
        title = "注册"
    }

    @IBAction func btn1c(_ sender: Any) {
        let vc = ServiceTypeViewController()
        vc.block = { (dic:NSDictionary) -> Void in
            self.serviceTypeLabel.text = dic.object(forKey: "catename") as? String
            self.serviceTypeID = dic.object(forKey: "id") as! String
            NSL("回调拿到的是\(self.serviceTypeID)")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn2c(_ sender: Any) {
        let vc = TLCityPickerController()
        vc.delegate = self
        let nav = BaseNavigationViewController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    
    @IBAction func next(_ sender: Any) {
        if check() {
            setData()
            let vc = RegisterThirdViewController(nibName: "RegisterThirdViewController", bundle: Bundle.main)
           navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension RegisterSecondViewController{
    func check() -> Bool{
        let empty = self.name.text?.isEmpty
        if empty! {
            showHUDMessage("请填写真实姓名", to: self.view)
            return false
        }
        let typeLabelText = serviceTypeLabel.text?.isEmpty
        let areaLabelText = serviceAreaLabel.text?.isEmpty
        let detailAdd = self.detailAddress.text?.isEmpty
        if typeLabelText! {
            showHUDMessage("请选择服务类型", to: self.view)
            return false
        }
        if areaLabelText! {
            showHUDMessage("请选择服务地区", to: self.view)
            return false
        }
        if detailAdd! {
            showHUDMessage("请填写提供服务的地址", to: self.view)
            return false
        }
        return true
    }
    
    func setData() {
        let model = RegistInfoModel.sharedInstance
        model.name = self.name.text
        model.workAge = self.workAges.text
        model.serviceType = self.serviceTypeLabel.text
        model.serviceTypeID = self.serviceTypeID
        model.serviceArea = self.serviceAreaLabel.text
        model.serviceAreaID = cityID
        model.serviceDetailAdd = self.detailAddress.text
        
    }
}
extension RegisterSecondViewController:TLCityPickerDelegate{
    func cityPickerController(_ cityPickerViewController: TLCityPickerController!, didSelect city: TLCity!) {
        cityID = city.cityID
        self.serviceAreaLabel.text = city.cityName
        cityPickerViewController.navigationController?.dismiss(animated: true, completion: nil)
    }
    func cityPickerControllerDidCancel(_ cityPickerViewController: TLCityPickerController!) {
        
    }
}
