//
//  MessageCell.swift
//  FootTec
//
//  Created by Admin on 16/11/23.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageType: UILabel!
    
    
    @IBOutlet weak var messageConten: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCellData(model:MessageModelList){
        messageType.text = model.title
        messageConten.text = model.content
        
        time.text = model.addTime
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
