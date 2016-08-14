//
//  Emoticon.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/29.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class Emoticon: NSObject {
//十六进制字符串
    var code :String?
    //type = 0代表图片表情,type==1 代表emoji表情
    var type :String?{
    
        didSet{
        
            isEmoji = type == "1"
        }
    }
    
    //图片描述
    var chs:String?
    
    //图片名
    var png:String?    //是否是emoji表情,默认不是
    var isEmoji:Bool = false
    
    //绝对路径
    var path:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
}
