//
//  FigureView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/25.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class FigureView: NSObject {

    var thumbnail_pic:String?
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
