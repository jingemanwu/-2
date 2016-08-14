//
//  MatchResult.swift
//  微博
//
//  Created by 牛晴晴 on 16/8/1.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class MatchResult: NSObject {

    var string:NSString?
    var range:NSRange
    init(string:NSString?,range:NSRange) {
        self.string = string
        self.range = range
        super.init()
    }
}
