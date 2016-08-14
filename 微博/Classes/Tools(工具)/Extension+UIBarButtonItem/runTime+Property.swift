//
//  runTime+Property.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/31.
//  Copyright © 2016年 SH. All rights reserved.
//

import Foundation

extension UIPageControl{
    
func printIvarList(clazz:AnyClass) -> [AnyObject]{
        
        var count : UInt32 = 0
        let ivars =  class_copyIvarList(clazz, &count)
        var names = [String]()
        for i in 0..<count{
            
            let ivar = ivars[Int(i)]
            //名字
            let name = ivar_getName(ivar)
            let nameString = String(CString: name, encoding: NSUTF8StringEncoding)
            names.append(nameString!)
            //类型
            let type = ivar_getTypeEncoding(ivar)
            let typeString = String(CString: type, encoding: NSUTF8StringEncoding)
            print("name=\(nameString ?? ""),type =\(typeString ?? "")")
        }
        return names
    }
}