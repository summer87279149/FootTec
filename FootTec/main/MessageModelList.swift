//
//	MessageModelList.swift
//
//	Create by Admin on 9/12/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MessageModelList{

	var addTime : String!
	var content : String!
	var id : String!
	var isread : String!
	var techId : String!
	var title : String!
	var type : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		addTime = dictionary["add_time"] as? String
		content = dictionary["content"] as? String
		id = dictionary["id"] as? String
		isread = dictionary["isread"] as? String
		techId = dictionary["tech_id"] as? String
		title = dictionary["title"] as? String
		type = dictionary["type"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if addTime != nil{
			dictionary["add_time"] = addTime
		}
		if content != nil{
			dictionary["content"] = content
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isread != nil{
			dictionary["isread"] = isread
		}
		if techId != nil{
			dictionary["tech_id"] = techId
		}
		if title != nil{
			dictionary["title"] = title
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}