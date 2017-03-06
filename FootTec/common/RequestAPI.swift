//
//  RequestAPI.swift
//  FootTec
//
//  Created by Admin on 16/12/5.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import Just
class RequestAPI: NSObject {
    class func get(urlString:String,params:[String:Any]?,complete:@escaping (AnyObject)->()){
        if let para = params {
              Just.get(urlString, params: para, timeout: 30.0,asyncCompletionHandler: { response in
                NSL(response)
                guard let r = response.json as?NSArray else{
                    NSL("GET无法解析")
                    return
                }
                complete(r)
            })
            
            
        }else{
           Just.get(urlString,timeout: 30.0){response in
            
            NSL(response)
            guard let r = response.json as?NSArray else{
                NSL("GET无法解析")
                return
            }
                complete(r)
            }
            
            
        }
        
    }
    
   class func post(urlString:String,params:[String:Any],data:[String : Any]){

        Just.post(urlString, params: params, data: data, timeout: 30.0,asyncCompletionHandler: {(response) in
        
        })
    }
    
}
