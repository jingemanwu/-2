//
//  UserAccountViewModel.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/22.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class UserAccountViewModel: NSObject {
    
    let path = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("user.data")
    // MARK: - 由于access_token可用于多次请求,且都是同一个,创建单例
    static var sharedModel = UserAccountViewModel()
    var userInfo:UserAccount?
    
   override init() {
    super.init()
        userInfo = unarchUser()
    }
    
//    - 为什么使用计算型属性？
//    - 时刻拿到accessToken 是否过期 要时刻和当前使用的日期对比 才准确 所以使用计算型属性
    var accessToken:String?{
    
        if userInfo?.access_token != nil {
            if userInfo?.expires_Date?.compare(NSDate()) == NSComparisonResult.OrderedDescending  {
                
                return userInfo?.access_token
                
            } else {
                
                return nil
            }
        }else{
        
            return nil
        }
        
    }
    // MARK: - 判断用户是否登录
    func isLogin() -> Bool{
        
       return accessToken != nil
        
    }
    
}

extension UserAccountViewModel{

    // MARK: - 归档
    func saveUser(userModel:UserAccount){
       userInfo = userModel
        NSKeyedArchiver.archiveRootObject(userModel, toFile: path)
        print(path)
    }
    
    func unarchUser() -> UserAccount?{
    
        let userModel :UserAccount? =   NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? UserAccount
        return userModel
    }
}
extension UserAccountViewModel{
    func accessUserInfoModel(code:String,isSuccess:(isSucces:Bool) -> ()){
        NetworkTools.sharedManage.accessUserInfo(code, success: { (Data) in
            
            guard let dict = Data as? [String:AnyObject] else {return}
            
            let userModel:UserAccount = UserAccount(dict: dict)
            
            self.userInfoModel(userModel,isSuccess: isSuccess)
            
            }, failure: { (error) in
                print(error)
        })
        
    }
    
    func userInfoModel(user:UserAccount,isSuccess:(Bool) -> ()){
        
        NetworkTools.sharedManage.UserInfo(user.access_token!, uid: user.uid!, success: { (Data) in
            
            guard let dict = Data as? [String : AnyObject] else {return}
            
            user.screen_name = dict["screen_name"] as?String
            user.avatar_large = dict["avatar_large"] as? String
            
            self.saveUser(user)
            isSuccess(true)
            
            }, failure: { (error) in
                isSuccess(false)
                print(error)
        })
    }

    
}
