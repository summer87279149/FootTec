//
//  ToShopTableViewCell.swift
//  FootTec
//
//  Created by Admin on 16/11/23.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class ToShopTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!

    @IBOutlet weak var tecName: UILabel!
    
    @IBOutlet weak var tecPrice: UILabel!
    @IBOutlet weak var tecTime: UILabel!
    
    @IBOutlet weak var tecAmount: UILabel!
    
    @IBOutlet weak var tecService: UILabel!
    
    @IBOutlet weak var tecPhone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCellData(model:ToShopModelList){
        img.layer.cornerRadius = 30
        img.layer.masksToBounds = true
        img.xt_setImage(urlString: model.headimgurl)
        tecName.text = model.name
        tecPhone.text = "电话:"+model.tel
        tecPrice.text = model.price+" 元"
        tecTime.text = "下单时间:"+model.addtime
        tecAmount.text = model.num+" 个"
        tecService.text = "服务名:"+model.projectname
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
