//
//  Extension+UILabel.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/20.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

extension UILabel {
   
    convenience  init(text:String?,textColor:UIColor?,textSize:CGFloat?,maxWidth:CGFloat = 0) {
        
        self.init()
        self.text = text;
        self.textColor = textColor
        self.font = UIFont.systemFontOfSize(textSize ?? UIFont.systemFontSize())
        if maxWidth > 0 {
            self.preferredMaxLayoutWidth = maxWidth
            self.numberOfLines = 0
        }
    }
}
