//
//  UserStatuse.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/23.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class UserStatuse: NSObject {
    //创建时间
    var created_at:String?
    //微博id
    var id:Int64 = 0
    //微博内容
    var text:String?
    //微博来源
    var source:String?
    //用户数据
    var user:User?
    //图片
    var pic_urls:[FigureView]?
    //  转发微博
    var retweeted_status:UserStatuse?
    
    // 转发数
    var reposts_count: Int = 0
    // 评论数
    var comments_count: Int = 0
    // 表态数
    var attitudes_count: Int = 0
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "user" {
           guard let vs = value as? [String:AnyObject] else { return }
          user =  User(dict: vs)
        } else if key == "retweeted_status"{
            
         guard let vs = value as? [String:AnyObject] else { return }
          retweeted_status =  UserStatuse(dict: vs)
            
        } else if key == "pic_urls"{
        
            guard let pi = value as? [[String:AnyObject]]  else { return }
            
            var tempArray :[FigureView] = [FigureView]()
            for dict in pi {
                tempArray.append(FigureView(dict: dict))
            }
            
            pic_urls = tempArray
            
        } else{
        
            super.setValue(value, forKey: key)
        }
        
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
