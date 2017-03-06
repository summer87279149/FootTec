//
//  AddServiceViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/25.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class AddServiceViewController: BaseUIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var mainImage: UIImageView!
    //项目类型
    @IBOutlet weak var typeLabel: UILabel!
    //名字
    @IBOutlet weak var nameLabel: UITextField!
    //时长
    @IBOutlet weak var timeLabel: UITextField!
    //是否上门
    @IBOutlet weak var isToHome: UISwitch!
    //项目介绍
    @IBOutlet weak var serviceInfo: UITextView!
    //价格
    @IBOutlet weak var priceLabel: UITextField!
    //还可以输入xx字
    @IBOutlet weak var characterCounts: UILabel!
    //记录点击的是哪个上传图片按钮 0:主图，  1:第一张， 2:第二张， 3:第三张
    var picNum = 10
    var imageMain:UIImage?
    var imageFirst:UIImage?
    var imageSecond:UIImage?
    var imageThird:UIImage?
    var typeID:String = "-1"
    var mainImageFilePath = ""
    var firstImageFilePath = ""
    var secondImageFilePath = ""
    var thirdImageFilePath = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        serviceInfo.delegate = self
    }
    @IBAction func typeBtnClicked(_ sender: Any) {
        let vc = ServiceTypeViewController()
        vc.block = { (dic:NSDictionary) -> Void in
            self.typeLabel.text = dic.object(forKey: "catename") as? String
            self.typeID = dic.object(forKey: "id") as! String
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //添加主图片
    @IBAction func addMainPic(_ sender: Any) {
        picNum = 0
         openActionSheet()
    }
    //添加第1张
    @IBAction func addFirstPic(_ sender: Any) {
        picNum = 1
         openActionSheet()
    }
    //添加第2张
    @IBAction func addSecPic(_ sender: Any) {
        picNum = 2
         openActionSheet()
    }
    //添加第3张
    @IBAction func addThirdPic(_ sender: Any) {
        picNum = 3
         openActionSheet()
    }
    //确认添加此项目
    @IBAction func addButtonClicked(_ sender: Any) {
        if check() {
            guard let name = nameLabel.text!.addingPercentEncoding(withAllowedCharacters:.urlPathAllowed) else {
                showHUDMessage("项目名含有非法字符", to: self.view)
                return
            }
            let time = timeLabel.text!
            var isToHomeValue = "0"
            if isToHome.isOn {
                isToHomeValue = "1"
            }else{
                isToHomeValue = "0"
            }
            let price = priceLabel.text!
            let type = self.typeID
           guard let info = serviceInfo.text!.addingPercentEncoding(withAllowedCharacters:.urlPathAllowed) else {
                showHUDMessage("项目介绍含有非法字符", to: self.view)
                return
            }
            guard let tecID = UserModel.userID else {
//                showHUDMessage("项目介绍含有非法字符", to: self.view)
                return
            }
            let para = ["projectname":name,"time":time,"isshangmen":isToHomeValue,"price":price,"category":type,"effect":info,"img":"\(firstImageFilePath),\(secondImageFilePath),\(thirdImageFilePath)","logo":mainImageFilePath,"tech_id":tecID]
             let dic = para as NSDictionary
                NSL("上传打印的参数:\(dic)")
            
            
            FootTecRequest.addServices(para: para, successRes: {
                NSL("确认添加项目后的回调:\($0)")
                if let msg = $0["msg"] as? String {
                    showHUDMessage(msg , to: self.view)
                    _ = self.navigationController?.dismiss(animated: true, completion: nil)
                }
                }, fail: {
                NSL("添加项目失败:\($0)")
                showHUDMessage("添加失败，请检查网络", to: self.view)
            })
            
        }
    }
    
    
    func cancel(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: - UITextView代理
extension AddServiceViewController:UITextViewDelegate{
    var count : Int{
        
        return 300 - serviceInfo.text.characters.count
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        characterCounts.text = "还可以输入\(count)字符"
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location>300{
            return false
        }else{
            return true
        }
    }
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        serviceInfo.resignFirstResponder()
        return false
    }
}

//MARK: - 选择照片代理
extension AddServiceViewController :UIActionSheetDelegate,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func openActionSheet()  {
        let actionSheet = UIActionSheet(title: "选择照片", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles:  "从相册选择")
        actionSheet.show(in: self.view)
    }
    
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
       if buttonIndex == 1{
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                openPhotoLibrary()
            }
        }else{
            
        }
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

        switch picNum {
        case 0:
            imageMain = info[UIImagePickerControllerEditedImage] as! UIImage?
            
            uploadImage(image: imageMain!, imageCardType: 0)
        case 1:
            imageFirst = info[UIImagePickerControllerEditedImage] as! UIImage?
            
            uploadImage(image: imageFirst!, imageCardType: 1)
        case 2:
            imageSecond = info[UIImagePickerControllerEditedImage] as! UIImage?
            
            uploadImage(image: imageSecond!, imageCardType: 2)
        case 3:
            imageThird = info[UIImagePickerControllerEditedImage] as! UIImage?
            
            uploadImage(image: imageThird!, imageCardType: 3)
        default: break
        }
    }
    //上传照片
    func uploadImage(image:UIImage,imageCardType:Int){
        showHUDIn(view: self.view)
        FootTecRequest.uploadServiceImages(image: image, successResponse: {
//            hideHUDIn(view: self.view)
            let dic : NSDictionary = $0 as! NSDictionary
             if let imurl:String = dic["img"] as? String{
                switch imageCardType{
                case 0:
                    self.mainImageFilePath = imurl
                    self.mainImage.image = self.imageMain
                    hideHUDIn(view: self.view)
                case 1:
                    self.firstImageFilePath = imurl
                    self.image1.image = self.imageFirst
                    hideHUDIn(view: self.view)
                case 2:
                    self.secondImageFilePath = imurl
                    self.image2.image = self.imageSecond
                    hideHUDIn(view: self.view)
                case 3:
                    self.thirdImageFilePath = imurl
                    self.image3.image = self.imageThird
                    hideHUDIn(view: self.view)
                default:
                    break
                }
            }
            NSL("上传照片回调\(dic)")
            
        
        }, failure: {
            hideHUDIn(view: self.view)
            showHUDMessage("上传失败，请稍后尝试", to: self.view)
            NSL("上传照片失败打印\($0)")
        })
        
    }
}
//MARK: - 设置UI 检验输入
extension AddServiceViewController{
    func setupUI(){
        self.title = "添加项目"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(cancel))
        image1.layer.borderWidth = 1
        image1.layer.cornerRadius = 3
        image1.layer.borderColor = FootFontColor.cgColor
        image2.layer.borderWidth = 1
        image2.layer.cornerRadius = 3
        image2.layer.borderColor = FootFontColor.cgColor
        image3.layer.borderWidth = 1
        image3.layer.cornerRadius = 3
        image3.layer.borderColor = FootFontColor.cgColor
        mainImage.layer.borderWidth = 1
        mainImage.layer.cornerRadius = 3
        mainImage.layer.borderColor = FootFontColor.cgColor
    }
    func check() -> Bool{
        if (nameLabel.text?.isEmpty)!{
            showHUDMessage("请填写项目名字", to: self.view)
            return false
        }
        
        if (timeLabel.text?.isEmpty)!{
            showHUDMessage("请填写时长", to: self.view)
            return false
        }
        if UserTool.validateNumber(timeLabel.text!){
            
        }else{
            showHUDMessage("时长请填写正确的整数(分钟)", to: self.view)
            return false
            
        }
        if let time = Int(timeLabel.text!) {
            NSL("time转换结果是:\(time)")
        }else {
            showHUDMessage("时长请填写正确的整数(分钟)", to: self.view)
            return false
        }
        
        if (priceLabel.text?.isEmpty)!{
            showHUDMessage("请填写价格", to: self.view)
            return false
        }
        
        if (serviceInfo.text?.isEmpty)!{
            showHUDMessage("请填写项目介绍", to: self.view)
            return false
        }
        
        if UserTool.validateNumber(priceLabel.text!){
            
        }else{
            showHUDMessage("单价请填写正确的整数金额", to: self.view)
            return false
        }
        
        if let price = Int(priceLabel.text!) {
            NSL("price转换结果是:\(price)")
        }else {
            showHUDMessage("单价请填写正确的整数金额", to: self.view)
            return false
        }
        if imageMain == nil {
            showHUDMessage("未添加主图片", to: self.view)
            return false
        }
        if imageFirst == nil {
            showHUDMessage("未添加第一张图片", to: self.view)
            return false
        }
        if imageSecond == nil {
            showHUDMessage("未添加第二张图片", to: self.view)
            return false
        }
        if imageThird == nil {
            showHUDMessage("未添加第三张图片", to: self.view)
            return false
        }
        
        return true
    }
}
