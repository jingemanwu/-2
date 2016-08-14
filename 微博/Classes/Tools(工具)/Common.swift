//
//  Common.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/20.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

// MARK: - 通知更换根控制器
let WBSwitchRootViewControllerNoti = "WBSwitchRootViewControllerNoti"
////微博账号
//let wbName = "rangyuan05788697@163.com"
//let wbPasswd = "bbb333"
//
////新浪微博相关信息
//let APPKEY = "2731071515"
//let APPSECRET = "60bd3eeadca2ef85d424a801cc2911a3"
//
////回调页
//let APPREDIRECT_URI = "http://www.baidu.com"

//微博账号
let wbName = "shuofuchi551@163.com"
let wbPasswd = "aaa333"

//新浪微博相关信息
let APPKEY = "3449423477"
let APPSECRET = "380200e2ded01753a3c071c207d99aaf"

//回调页
let APPREDIRECT_URI = "http://www.baidu.com/"




//主体颜色
let ThemeColor = UIColor.orangeColor()

//屏幕的宽和高
let SCREENW = UIScreen.mainScreen().bounds.width
let SCREENH = UIScreen.mainScreen().bounds.height

//点击表情按钮
let EmoticonPictureClick = "EmoticonPictureClick"
//点击删除表情按钮
let EmoticonDeleteClick = "EmoticonDeleteClick"

//RGB颜色
func RGB(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat = 1) -> UIColor{
    
       return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    
}

//随机颜色
func RandomColor() -> UIColor{

    let r = random() % 256
    let g = random() % 256
    let b = random() % 256
    return RGB(CGFloat(r), green: CGFloat(g), blue: CGFloat(b))
}

