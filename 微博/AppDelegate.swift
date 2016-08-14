//
//  AppDelegate.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SVProgressHUD

@available(iOS 9.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = NewfeatureViewController()
        window?.makeKeyAndVisible()
        setup()
        
//        EmoticonTools.sharedTools.arrayTwo()
        let versn:Bool = isNewVersion()
//        window?.rootViewController = ComposeViewController()
//        暂时更改
        version(versn)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.notification(_:)), name: WBSwitchRootViewControllerNoti, object: nil)
        return true
    }
    
    // MARK: - 判断版本
    func isNewVersion() -> Bool{
    
        let dict = NSBundle.mainBundle().infoDictionary
        
        let newVersion:Double = Double(dict!["CFBundleShortVersionString"] as! String)!
        let Version = Double((NSUserDefaults.standardUserDefaults().objectForKey("version") as? String) ?? "")
        if Version == nil {
            NSUserDefaults.standardUserDefaults().setDouble(newVersion, forKey: "version")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        if Version < newVersion {
            return false
        }
        
        return true
    }
    // MARK: - 新版本切换
    func version(vers:Bool){
        
            if  UserAccountViewModel.sharedModel.isLogin(){
                if vers {
                    
                    window?.rootViewController = NewfeatureViewController()
                } else {
                    
                    window?.rootViewController = WelcomeViewController()
                }
            } else {
            
                window?.rootViewController = MainViewController()
            }
            
      
        
    }
    // MARK: - 新特性和登录切换
    func notification(info:NSNotification){
        
        if info.object == nil {
            window?.rootViewController = WelcomeViewController()
        }
        else{

            window?.rootViewController = MainViewController()
        }
    }
    //
    func setup(){
        
//        UITabBar.appearance().tintColor = UIColor.orangeColor();
        UINavigationBar.appearance().tintColor = ThemeColor
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Custom)
        SVProgressHUD.setBackgroundColor(ThemeColor)
        SVProgressHUD.setForegroundColor(UIColor.redColor())
        
    }
    
    deinit{
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}

