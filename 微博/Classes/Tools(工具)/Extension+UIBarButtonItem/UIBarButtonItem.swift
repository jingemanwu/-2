//
//  UIBarButtonItem.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
//title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VisitorViewController.btnClick)
    convenience init(titles: String?,images:String?, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector) {
      
        self.init()
        let button = UIButton()
        if let ti = titles {
            
            button.setTitle(ti, forState: .Normal)
                button.setTitleColor(ThemeColor, forState: .Normal)
            button.setTitleColor(UIColor.grayColor(), forState: .Disabled)
           
        }
        else
        {
            
            button.setImage(UIImage(named: images!), forState: .Normal)
        }
        button.sizeToFit()
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        self.customView = button
    }
}
