//
//  CommentTableViewCell.swift
//  FootTec
//
//  Created by Admin on 16/11/24.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import SnapKit
class CommentTableViewCell: UITableViewCell {

    var nameLabel:UILabel?
    var content:UILabel?
    var projectNameLabel:UILabel?
    var time:UILabel?
    var star:TQStarRatingView?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel = UILabel()
        nameLabel?.text = "我是用户名称"
        nameLabel?.font = UIFont.systemFont(ofSize: 14)
        nameLabel?.textColor = FootFontColor
        self.contentView.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.left.equalToSuperview().offset(10)
            ConstraintMaker.top.equalToSuperview().offset(10)
            ConstraintMaker.width.equalTo(UIScreen.main.bounds.size.width-100)
        })
        
        content = UILabel()
        content?.font = UIFont.systemFont(ofSize: 12)
        content?.textColor = FootFontColor
        content?.lineBreakMode = .byCharWrapping
        content?.numberOfLines = 0
        content?.text = "我是用户评价内容,我是用户评价内容,我是用户评价内容,我是用户评价内容"
        self.contentView.addSubview(content!)
        content?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalTo((nameLabel?.snp.bottom)!).offset(10)
            ConstraintMaker.left.equalTo((nameLabel?.snp.left)!)
            ConstraintMaker.width.equalTo(UIScreen.main.bounds.size.width-100)
        })
        
        projectNameLabel = UILabel()
        projectNameLabel?.text = "我是项目名称"
        projectNameLabel?.font = UIFont.systemFont(ofSize: 12)
        projectNameLabel?.textColor = UIColor.darkGray
        projectNameLabel?.textAlignment = .right
        self.contentView.addSubview(projectNameLabel!)
        projectNameLabel?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalTo((nameLabel?.snp.top)!)
            ConstraintMaker.right.equalToSuperview().offset(-10)
        })
        
        time = UILabel()
        time?.font = UIFont.systemFont(ofSize: 12)
        time?.textColor = UIColor.darkGray
        time?.textAlignment = .right
        self.contentView.addSubview(time!)
        time?.text = "2016-11-12"
        time?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalTo(content!)
            ConstraintMaker.right.equalTo((projectNameLabel?.snp.right)!)
        })
        
        star = TQStarRatingView(frame: CGRect(x: 100, y: 100, width: kScreenWidth/3, height: (kScreenWidth-20)/15))
        star?.setScore(0.5, withAnimation: true)
        star?.isUserInteractionEnabled = false
        self.contentView.addSubview(star!)
        star?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.top.equalTo((self.content?.snp.bottom)!).offset(10)
            ConstraintMaker.right.equalTo((time?.snp.right)!)
            ConstraintMaker.width.equalTo(kScreenWidth/3)
            ConstraintMaker.height.equalTo(kScreenWidth/15)
            ConstraintMaker.bottom.equalToSuperview()
        })
//        contentView.snp.makeConstraints { (make) -> Void in
//            make.bottom.equalTo((self.star?.snp.bottom)!).offset(5)
//            make.left.equalTo(self)
//            make.top.equalTo(self)
//            make.right.equalTo(self)
//        }
        
        
       
        
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellData(model:MyCommentsList) {
      self.nameLabel?.text = model.nickname
        self.content?.text = model.content
        self.projectNameLabel?.text = model.projectname
        self.time?.text = model.date
        if let star = Float(model.stars) {
            self.star?.setScore(star/5, withAnimation: false)
        }else{
            self.star?.setScore(0.5, withAnimation: false)
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
