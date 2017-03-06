//
//  BaseNavigationViewController.swift
//  FootTec
//
//  Created by Admin on 16/11/22.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //导航栏背景色
       navigationBar.barTintColor = sNavColor
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:sm_RGBColor(59,41,53)]
         self.navigationBar.tintColor=FootFontColor;
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
