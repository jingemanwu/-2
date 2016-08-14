//
//  ComposeModel.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/28.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class ComposeModel: NSObject {

    var nextvc:String?
    var icon:String?
    var title:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
