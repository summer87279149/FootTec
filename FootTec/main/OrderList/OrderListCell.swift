//
//  OrderListCell.swift
//  FootTec
//
//  Created by Admin on 16/11/23.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class OrderListCell: UITableViewCell {

    @IBOutlet weak var tecName: UILabel!
    @IBOutlet weak var tecTime: UILabel!
    
    @IBOutlet weak var tecPrice: UILabel!
    
    @IBOutlet weak var tecAmount: UILabel!
    
    @IBOutlet weak var tecAdd: UILabel!
    
    @IBOutlet weak var tecService: UILabel!
    
    @IBOutlet weak var pic: UIImageView!
    
    @IBOutlet weak var tecPhone: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellData(model:List) {
        pic.layer.cornerRadius = 30
        pic.layer.masksToBounds = true
        pic.xt_setImage(urlString: model.headimgurl)
        self.tecName.text = model.name
        tecTime.text = "预定时间:"+model.addtime
        tecPrice.text = model.price+" 元"
        tecAmount.text = model.num+" 个"
        tecAdd.text = "地址:"+model.address
        tecService.text = "服务名:"+model.projectname
        tecPhone.text = "电话:"+model.tel
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
