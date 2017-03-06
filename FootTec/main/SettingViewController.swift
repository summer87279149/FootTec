//
//  SettingViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/22.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class SettingViewController: BaseUIViewController {

    @IBOutlet weak var image1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人设置"
        image1.layer.borderWidth = 1
        image1.layer.cornerRadius = 60
        image1.layer.masksToBounds = true
        image1.layer.borderColor = FootFontColor.cgColor
        if let imgUrl = UserModel.userImg {
            image1.xt_setImage(urlString: imgUrl)
        }

    }

    
    
    
    @IBAction func modifyImage(_ sender: Any) {
        
        
        openActionSheet()
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserModel.logOut()
        NSL("发出logOut通知")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logOut"), object: nil)
       _ = self.navigationController?.popToRootViewController(animated: false)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
extension SettingViewController :UIActionSheetDelegate,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
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
        //拿到照片
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            picker.dismiss(animated: true, completion: nil)
           //拿到照片
            if  let img = info[UIImagePickerControllerEditedImage] as! UIImage? {
                upload(image: img)
            }
            
        }
        func upload(image:UIImage){
            guard let uid = UserModel.userID else{
                return }
            FootTecRequest.uploadTecPortrait(image: image, tech_id: uid, successResponse: {
                NSL("提交头像照片返回是:\($0)")
                if let dic = $0 as? NSDictionary{
                    if let imgStr = dic["imgurl"] as? String{
                        UserModel.userImg = imgStr
                        self.image1.xt_setImage(urlString: imgStr)
                        NSL("提交头像发出protrait通知")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "protrait"), object: nil, userInfo: ["imgUrl":imgStr])
                    }
                }
            }, failure: {
                showHUDMessage("请检查网络连接", to: self.view)
            NSL($0)
            })
        }
    
    
    
    
    
}
