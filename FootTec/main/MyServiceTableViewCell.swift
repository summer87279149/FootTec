//
//  MyServiceTableViewCell.swift
//  FootTec
//
//  Created by Admin on 16/11/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class MyServiceTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var serviceImage: UIImageView!
    
    @IBOutlet weak var serviceName: UILabel!
    
    @IBOutlet weak var serviceWork: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var toHome: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    
    func setCellData(model:MyServicesList) {
        self.serviceImage.xt_setImage(urlString: model.logo)
        self.serviceName.text = model.projectname
        if model.effect.characters.count>40{
           let index = model.effect.index(model.effect.startIndex, offsetBy: 40)
            let a = model.effect.substring(to: index)+"..."
            self.serviceWork.text = a
        }else{
             self.serviceWork.text = model.effect
        }
        
        self.time.text = model.time+"分钟"
        if model.isshangmen == "0" {
            self.toHome.text = "上门服务:不支持"
        }else{
            self.toHome.text = "上门服务:支持"
        }
        self.price.text = "单价:"+model.price+"元"
    }
    
    
    
    
    
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
