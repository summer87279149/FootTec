//
//  AppDelegate.swift
//  FootTec
//
//  Created by Admin on 16/11/21.
//  Copyright © 2016年 Admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var menuViewController : REFrostedViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: kScreenBounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = setupUI()
        self.window?.makeKeyAndVisible()
        sm_SetJPUSH(launchOptions)
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //进入前台将消息角标变为0
        JPUSHService.setBadge(0)
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}
//设置keywindow的UI
extension AppDelegate{
    func setupUI() -> (REFrostedViewController){
        let orderList = customedSegmentViewController()
        orderList.title = "我的接单"
        let leftNavBtnView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.addTarget(self, action: #selector(leftNavBtnClicked), for: .touchUpInside)
        button.backgroundColor = sClearColor
        leftNavBtnView.addSubview(button)
        if UserModel.userImg != nil{
            if let urlStr = UserModel.userImg ,let url = URL(string: urlStr) ,let da = try? Data.init(contentsOf: url){
                button.setImage(UIImage.init(data: da), for: .normal)
            }
        }else{
            button.setImage(UIImage.init(named: "5"), for: .normal)
        }
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        //网络请求完成后设置leftNavBtnImg，删除这行button.setTitle
        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "LoginSuccess"), object: nil, queue: nil) { (Notification) in
            NSL("AppDelegate接收到LoginSuccess通知:\(Notification)")
            if let _ = Notification.userInfo!["imgUrl"] as? String {
//                NSL("打印通知传过来的参数\(imgUrl)")
                if let urlStr = UserModel.userImg ,let url = URL(string: urlStr) ,let da = try? Data.init(contentsOf: url){
                    button.setImage(UIImage.init(data: da), for: .normal)
                }
            }
        }
        //
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "protrait"), object: nil, queue: nil, using: {
            NSL("AppDelegate接收到protrait通知:\($0)")
            if let _ = $0.userInfo!["imgUrl"] as? String {
                /**在这里修改button 的image*/
                if let urlStr = UserModel.userImg ,let url = URL(string: urlStr) ,let da = try? Data.init(contentsOf: url){
                    button.setImage(UIImage.init(data: da), for: .normal)
                }
            }
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "logOut"), object: nil, queue: nil, using: {
            NSL("AppDelegate接收到logOut通知:\($0)")
             button.setImage(nil, for: .normal)
        })

        let leftNavBtnImg =  UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        leftNavBtnView.addSubview(leftNavBtnImg)
        let leftNavBtn = UIBarButtonItem(customView: leftNavBtnView)
        orderList.navigationItem.leftBarButtonItem = leftNavBtn
        let nav = BaseNavigationViewController(rootViewController: orderList)
        let leftVC = LeftTableViewController()
        self.menuViewController = REFrostedViewController(contentViewController: nav, menuViewController: leftVC)
        return self.menuViewController!
    }
    
    func leftNavBtnClicked()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.menuViewController!.presentMenuViewController()
    }
    
    fileprivate func customedSegmentViewController() -> OrderViewController{
        let vc = OrderViewController()
        return vc
    }
    
    fileprivate func customedPageController() -> PageController {
        let vcClasses: [BaseUIViewController.Type] = [ToHomeViewController.self, ToShopViewController.self]
        let titles = ["上门订单", "到店订单"]
        let pageController = PageController(vcClasses: vcClasses, theirTitles: titles)
        pageController.pageAnimatable = true
        pageController.menuViewStyle = MenuViewStyle.line
        pageController.bounces = true
        pageController.menuHeight = 44
        pageController.titleSizeSelected = 15
        pageController.menuBGColor = sViewColor
        pageController.progressColor = sm_RGBColor(59,41,53)
        return pageController
    }
   
    
}
//所有极光推送相关
extension AppDelegate : JPUSHRegisterDelegate{
    //didfinish方法中只需要调用 sm_SetJPUSH
    func sm_SetJPUSH(_ launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
        if #available(iOS 10.0, *){
            let entiity = JPUSHRegisterEntity()
            entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
                UNAuthorizationOptions.badge.rawValue |
                UNAuthorizationOptions.sound.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
        } else if #available(iOS 8.0, *) {
            let types = UIUserNotificationType.badge.rawValue |
                UIUserNotificationType.sound.rawValue |
                UIUserNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        }else {
            let type = UIRemoteNotificationType.badge.rawValue |
                UIRemoteNotificationType.sound.rawValue |
                UIRemoteNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
        }
        
        JPUSHService.setup(withOption: launchOptions,
                           appKey: "ee75b762c8ade49bd6677d49",
                           channel: nil,
                           apsForProduction: true)
        JPUSHService.setBadge(0)
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        NSL("iOS7～10接收到 本地 通知：\(notification.userInfo)")
    }
    //基于iOS 7 及以上的系统版本
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        NSL("iOS7～10接收到 远程 通知：\(userInfo)")
        
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.newData)
    }
    //基于iOS 6 及以下的系统版本
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        NSL("iOS6以下接收到 远程 通知：\(userInfo)")
        JPUSHService.handleRemoteNotification(userInfo)
    }
    //基于iOS 10及以上的系统版本
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter willPresent");
        let userInfo = notification.request.content.userInfo
        
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            NSL("iOS10即将接收到 远程 通知：\(userInfo)")
            JPUSHService.handleRemoteNotification(userInfo)
        }else{
            //本地通知
            NSL("iOS10即将接收到 本地 通知：\(userInfo)")
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue))// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    }
    //基于iOS 10及以上的系统版本
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter didReceive");
        let userInfo = response.notification.request.content.userInfo
        
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            NSL("iOS10已经接收到 远程 通知：\(userInfo)")
            JPUSHService.handleRemoteNotification(userInfo)
        }else{
            //本地通知
            NSL("iOS10已经接收到 远程 通知：\(userInfo)")
        }
        completionHandler()
    }
}
