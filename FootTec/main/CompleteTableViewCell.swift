//
//  CompleteTableViewCell.swift
//  FootTec
//
//  Created by Admin on 16/11/23.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class CompleteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    
   
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var effect: UILabel!
    
    
    @IBOutlet weak var customName: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setCellData(model:CompleteOrderModelList){
        img.layer.cornerRadius = 3
        img.layer.masksToBounds = true
        img.xt_setImage(urlString: model.headimgurl)
        name.text = model.projectname
        if model.effect.characters.count>31{
            let index = model.effect.index(model.effect.startIndex, offsetBy: 31)
            let a = model.effect.substring(to: index)+"..."
            self.effect.text = a
        }else{
            self.effect.text = model.effect
        }
        customName.text = "下单人:"+model.name
        price.text = "总计:"+model.price
        time.text = "时间:"+model.addtime
        
        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
