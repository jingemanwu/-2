//
//  BarButtonItem.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class BarButtonItem: UIBarButtonItem {

init(title: String?,image:String?, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector) {
    super.init()
    let button = UIButton()
    if let ti = title {
        button.setTitle(ti, forState: .Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: .Normal)
    }
    else
    {
        
        button.setImage(UIImage(named: image!), forState: .Normal)
    }
    button.sizeToFit()
    button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
    self.customView = button

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
