//
//  UserAccount.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/22.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {

    var access_token:String?
    var expires_in:NSTimeInterval = 0{
    
        didSet{
        
            expires_Date = NSDate(timeIntervalSinceNow: expires_in )
            print(expires_Date)
            
        }
    }
    var uid:String?
    var screen_name:String?
    var avatar_large:String?
    var expires_Date:NSDate?
    
    init(dict:[String:AnyObject]) {
        super.init()
    
    setValuesForKeysWithDictionary(dict)
    
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
    
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_Date, forKey: "expires_Date")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        
    }
    
    required  init?(coder aDecoder: NSCoder) {
       
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_Date = aDecoder.decodeObjectForKey("expires_Date") as? NSDate
        
        uid = aDecoder.decodeObjectForKey("uid") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        
    }
    
    override var description: String{
    let array = ["access_token","expires_in","uid","screen_name","avatar_large","expires_Date"]
      let dict =   dictionaryWithValuesForKeys(array)
        return dict.description
    }
}


