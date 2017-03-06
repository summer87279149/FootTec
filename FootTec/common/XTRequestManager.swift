//
//  XTRequestManager.swift
//  FootTec
//
//  Created by Admin on 16/12/5.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit
import AFNetworking
enum NHResponseSeializerType {
    case NHResponseSeializerTypeDefault
    case NHResponseSeializerTypeJSON
    case NHResponseSeializerTypeXML
    case NHResponseSeializerTypePlist
    case NHResponseSeializerTypeCompound
    case NHResponseSeializerTypeImage
    case NHResponseSeializerTypeData
}
//单例
let sharedManager = AFHTTPSessionManager()

extension AFHTTPSessionManager {
    class var sharedmanager : AFHTTPSessionManager {
        return sharedManager
    }
}

class XTRequestManager: NSObject {
   class func get(_ urlString:String, parameters para:AnyObject, responseSeializer type:NHResponseSeializerType,andSuccess success:@escaping (_ responseObject:AnyObject)->(),andFailure failure:@escaping (_ error:NSError)->()){
        let manager = AFHTTPSessionManager.sharedmanager
        manager.requestSerializer.timeoutInterval = 30.0
        if type != .NHResponseSeializerTypeJSON && type != .NHResponseSeializerTypeDefault {
             manager.responseSerializer = responseSeializer(serilizerType: type)
        }
    manager.get(urlString, parameters: para, progress: nil, success: {(task:URLSessionDataTask,responseObject: Any?) -> Void in
           success(responseObject as AnyObject)
    
    }, failure: {( task:URLSessionDataTask?, Error:Any) -> Void in
        failure(Error as! NSError)
    })
    
    
    
    
    }
    
  class  func responseSeializer(serilizerType:NHResponseSeializerType) -> AFHTTPResponseSerializer {
        switch (serilizerType) {
            
        case .NHResponseSeializerTypeDefault: // default is JSON
            return AFJSONResponseSerializer()
            
            
        case .NHResponseSeializerTypeJSON: // JSON
            return AFJSONResponseSerializer()
           
            
        case .NHResponseSeializerTypeXML: // XML
            return AFXMLParserResponseSerializer()
           
            
        case .NHResponseSeializerTypePlist: // Plist
            return AFPropertyListResponseSerializer()
          
            
        case .NHResponseSeializerTypeCompound: // Compound
            return AFCompoundResponseSerializer()
            
            
        case .NHResponseSeializerTypeImage: // Image
            return AFImageResponseSerializer()
         
            
        case .NHResponseSeializerTypeData: // Data
            return AFHTTPResponseSerializer()
          
            
        default:  // 默认解析器为 JSON解析
            return AFJSONResponseSerializer()
           
        }

    }
}
