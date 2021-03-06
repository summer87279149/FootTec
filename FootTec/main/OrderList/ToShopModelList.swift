//
//	ToShopModelList.swift
//
//	Create by Admin on 6/12/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ToShopModelList{

	var address : String!
	var addtime : String!
	var distance : String!
	var headimgurl : String!
	var lat : String!
	var lng : String!
	var name : String!
	var num : String!
	var pid : String!
	var price : String!
	var projectId : String!
	var projectname : String!
	var shopId : String!
	var technicianId : String!
	var tel : String!
	var totalprice : String!
	var userId : String!
	var zid : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		address = dictionary["address"] as? String
		addtime = dictionary["addtime"] as? String
		distance = dictionary["distance"] as? String
		headimgurl = dictionary["headimgurl"] as? String
		lat = dictionary["lat"] as? String
		lng = dictionary["lng"] as? String
		name = dictionary["name"] as? String
		num = dictionary["num"] as? String
		pid = dictionary["pid"] as? String
		price = dictionary["price"] as? String
		projectId = dictionary["project_id"] as? String
		projectname = dictionary["projectname"] as? String
		shopId = dictionary["shop_id"] as? String
		technicianId = dictionary["technician_id"] as? String
		tel = dictionary["tel"] as? String
		totalprice = dictionary["totalprice"] as? String
		userId = dictionary["user_id"] as? String
		zid = dictionary["zid"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if address != nil{
			dictionary["address"] = address
		}
		if addtime != nil{
			dictionary["addtime"] = addtime
		}
		if distance != nil{
			dictionary["distance"] = distance
		}
		if headimgurl != nil{
			dictionary["headimgurl"] = headimgurl
		}
		if lat != nil{
			dictionary["lat"] = lat
		}
		if lng != nil{
			dictionary["lng"] = lng
		}
		if name != nil{
			dictionary["name"] = name
		}
		if num != nil{
			dictionary["num"] = num
		}
		if pid != nil{
			dictionary["pid"] = pid
		}
		if price != nil{
			dictionary["price"] = price
		}
		if projectId != nil{
			dictionary["project_id"] = projectId
		}
		if projectname != nil{
			dictionary["projectname"] = projectname
		}
		if shopId != nil{
			dictionary["shop_id"] = shopId
		}
		if technicianId != nil{
			dictionary["technician_id"] = technicianId
		}
		if tel != nil{
			dictionary["tel"] = tel
		}
		if totalprice != nil{
			dictionary["totalprice"] = totalprice
		}
		if userId != nil{
			dictionary["user_id"] = userId
		}
		if zid != nil{
			dictionary["zid"] = zid
		}
		return dictionary
	}

}