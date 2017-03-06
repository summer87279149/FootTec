//
//	MyServicesList.swift
//
//	Create by Admin on 8/12/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MyServicesList{

	var effect : String!
	var img : String!
	var isshangmen : String!
	var logo : String!
	var pid : String!
	var price : String!
	var projectname : String!
	var techId : String!
	var time : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		effect = dictionary["effect"] as? String
		img = dictionary["img"] as? String
		isshangmen = dictionary["isshangmen"] as? String
		logo = dictionary["logo"] as? String
		pid = dictionary["pid"] as? String
		price = dictionary["price"] as? String
		projectname = dictionary["projectname"] as? String
		techId = dictionary["tech_id"] as? String
		time = dictionary["time"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if effect != nil{
			dictionary["effect"] = effect
		}
		if img != nil{
			dictionary["img"] = img
		}
		if isshangmen != nil{
			dictionary["isshangmen"] = isshangmen
		}
		if logo != nil{
			dictionary["logo"] = logo
		}
		if pid != nil{
			dictionary["pid"] = pid
		}
		if price != nil{
			dictionary["price"] = price
		}
		if projectname != nil{
			dictionary["projectname"] = projectname
		}
		if techId != nil{
			dictionary["tech_id"] = techId
		}
		if time != nil{
			dictionary["time"] = time
		}
		return dictionary
	}

}