//
//  OrderViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/23.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class OrderViewController: BaseUIViewController {
    let titleArr = ["上门订单","到店订单"]
    let VCArr = [ToHomeViewController(),ToShopViewController()]
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = SegmentViewController()
        vc.titleArray = self.titleArr
        vc.titleSelectedColor = UIColor.red;
        vc.subViewControllers = VCArr;
        vc.buttonWidth = 80;
        vc.buttonHeight = 50;
        vc.initSegment()
        vc.addParentController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
