//
//  User.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/23.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class User: NSObject {
//用户ID
    var id:Int = 0
    //用户显示名称
    var name:String?
    //用户头像地址(中国),50×50像素
    var profile_image_url:String?
    
    //认证类型 -1:没有认证,1.认证用户,2,3,5企业认证,220达人
    var verified:Int = 0
    //会员等级 1-6
    var mbrank:Int = 0
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}

