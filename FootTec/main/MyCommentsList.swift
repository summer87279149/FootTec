//
//	MyCommentsList.swift
//
//	Create by Admin on 8/12/2016
//	Copyright © 2016. All rights reserved.


import Foundation

struct MyCommentsList{

	var content : String!
	var date : String!
	var name : String!
	var nickname : String!
	var orderId : String!
	var projectname : String!
	var stars : String!
	var techId : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		content = dictionary["content"] as? String
		date = dictionary["date"] as? String
		name = dictionary["name"] as? String
		nickname = dictionary["nickname"] as? String
		orderId = dictionary["order_id"] as? String
		projectname = dictionary["projectname"] as? String
		stars = dictionary["stars"] as? String
		techId = dictionary["tech_id"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if content != nil{
			dictionary["content"] = content
		}
		if date != nil{
			dictionary["date"] = date
		}
		if name != nil{
			dictionary["name"] = name
		}
		if nickname != nil{
			dictionary["nickname"] = nickname
		}
		if orderId != nil{
			dictionary["order_id"] = orderId
		}
		if projectname != nil{
			dictionary["projectname"] = projectname
		}
		if stars != nil{
			dictionary["stars"] = stars
		}
		if techId != nil{
			dictionary["tech_id"] = techId
		}
		return dictionary
	}

}
