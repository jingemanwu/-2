//
//  Extension+NSDate.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/26.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
private let formatter = NSDateFormatter()

extension NSDate {
  
    class func current(current:String?) -> NSDate?{
        guard let cur = current else {return nil}
        
        // MARK: - 把字符串转时间
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        formatter.dateFormat = "EEE MMM dd HH:mm:ss z yyyy"
        
       return formatter.dateFromString(cur)!
    }
    
    var currentDate:String? {
        
        if sinaIsThisYear(self){
        //日历类
        let calend = NSCalendar.currentCalendar()
        //今天
        if calend.isDateInToday(self) {
            
            //小于60秒,系统时间与微博时间的时间差
            let time = Int(NSDate().timeIntervalSinceDate(self))
            if  time < 60 {
                return "刚刚"
            } else if time >= 60 && time < 3600 {
                
                return "\(time / 60)分钟之前"
            } else {
                
                
                return "\(time / 3600)小时之前"
            }
            
        } else if calend.isDateInYesterday(self){ //昨天
            
            formatter.dateFormat = "昨天 HH:mm"
            
        }else{ //其他
            
            formatter.dateFormat = "MM月dd日 HH:mm"
            
        }
    } else {
    
       formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
    }
    
    return formatter.stringFromDate(self)
    
    }
    // MARK: - 判断是不是今年
    func sinaIsThisYear(sinaDate:NSDate) -> Bool{
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        formatter.dateFormat = "yyyy"
        
        let sinaDT = formatter.stringFromDate(sinaDate)
        let date = NSDate()
        let currDt = formatter.stringFromDate(date)
        if sinaDT == currDt {
            
            return true
            
        } else {
            
            return false
        }
        
        
    }

}
