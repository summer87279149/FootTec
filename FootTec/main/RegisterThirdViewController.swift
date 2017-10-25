//
//  RegisterThirdViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/25.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterThirdViewController: BaseUIViewController {
    
    //记录点击的是第一个按钮还是第二个
    //1代表第一个，2代表第二个
    var clickWhich = 0
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        image1.layer.borderWidth = 1
        image1.layer.cornerRadius = 3
        image1.layer.borderColor = FootFontColor.cgColor
        image2.layer.borderWidth = 1
        image2.layer.cornerRadius = 3
        image2.layer.borderColor = FootFontColor.cgColor
        
    }
    
    //上传1
    @IBAction func upload1(_ sender: Any) {
        clickWhich = 1
        openActionSheet()
    }
    
    //上传2
    @IBAction func upload2(_ sender: Any) {
        clickWhich = 2
        openActionSheet()
    }
    //注册点击
    @IBAction func regist(_ sender: Any) {
        let model = RegistInfoModel.sharedInstance
        model.printAll()
        if model.image1Url != nil{
            if model.image2Url != nil{
                showHUDIn(view: self.view)
                FootTecRequest.register(account: model.phoneNumber!, password: model.password!, name: model.name!, cateid: model.serviceTypeID!, area: model.serviceAreaID!, address: model.serviceDetailAdd!, verifyCode: model.vertifyCode!, work_years: model.workAge!,card1:model.image1Url!,card2:model.image2Url!,successRes: { [unowned self] (res) in
                    hideHUDIn(view: self.view)
                    
                    _ = self.navigationController?.popToRootViewController(animated: false)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RegisteOK"), object: nil)
                    }, fail: { (err) in
                        hideHUDIn(view: self.view)
                })
                
            }else{
                showHUDMessage("请上传身份证图片", to: self.view)
            }
        }else{
            showHUDMessage("请上传身份证图片", to: self.view)
        }
    }
    
    //同意协议
    @IBAction func agree(_ sender: Any) {
        let vc = YinSiViewController(nibName: "YinSiViewController", bundle: Bundle.main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension RegisterThirdViewController :UIActionSheetDelegate,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    
    func openActionSheet()  {
        let actionSheet = UIActionSheet(title: "选择照片", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册选择")
        actionSheet.show(in: self.view)
    }
    
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        if buttonIndex==1 {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                openCrama()
            }
        }else if buttonIndex == 2{
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                openPhotoLibrary()
            }
        }else{
            
        }
    }
    
    func openCrama(){
        let picker1 = UIImagePickerController()
        picker1.sourceType = .camera
        picker1.cameraDevice = .rear
        picker1.delegate = self
        picker1.allowsEditing = true
        self.present(picker1, animated: true, completion: nil)
    }
    func openPhotoLibrary(){
        let picker2 = UIImagePickerController()
        picker2.sourceType = .photoLibrary
        picker2.delegate = self
        picker2.allowsEditing = true
        self.present(picker2, animated: true, completion: nil)
    }
    //把拍到的照片保存到uploadImage
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let model = RegistInfoModel.sharedInstance
        if clickWhich == 1{
            model.uploadImage1 =  info[UIImagePickerControllerEditedImage] as! UIImage?
            uploadImage(image: model.uploadImage1!,imageCardType: 1)
        }else if clickWhich == 2{
            model.uploadImage2 =  info[UIImagePickerControllerEditedImage] as! UIImage?
            uploadImage(image: model.uploadImage2!,imageCardType: 2)
        }
    }
    
    func uploadImage(image:UIImage,imageCardType:Int){
        showHUDIn(view: self.view)
        FootTecRequest.uploadCard(cardImage: image, successResponse: { response in
            let dic : NSDictionary = response as! NSDictionary
            if let imurl:String = dic["imgurl"] as? String{
                let model = RegistInfoModel.sharedInstance
                switch imageCardType {
                case 1:
                    //正面
                    model.image1Url = imurl
                    self.image1.image = model.uploadImage1
                    hideHUDIn(view: self.view)
                case 2:
                    //反面
                    model.image2Url = imurl
                    self.image2.image = model.uploadImage2
                    hideHUDIn(view: self.view)
                default:
                    break
                }
            }
            
        }, failure: {err in
            hideHUDIn(view: self.view)
            showHUDMessage("上传失败，请稍后尝试", to: self.view)
            NSL(err)
            
        })
    }
    
    
}
