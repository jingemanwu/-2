//
//  StatusDAL.swift
//  微博
//
//  Created by 牛晴晴 on 16/8/1.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class StatusDAL: NSObject {
    /*
     01 - 查询数据 -> 返回数据
     - 如果查询本地有数据  直接返回
     - 如果查询本地没有数据
     - 网络请求数据
     - 保存数据
     02 - 保存数据
     
     03 - 删除数据
     */
    // 检查本地是否有数据
    class func checkCache(sinceId:Int64,maxId:Int64,callback:(response:[[String: AnyObject]]?)->()) {
        
        let selectData = StatusDAL.getCache(sinceId, maxId: maxId)
        if selectData?.count > 0 {
        
            callback(response: selectData)
        } else {
        
            NetworkTools.sharedManage.statuses(sinceId, max_id: maxId, success: { (Data) in
               
                guard let array = Data?["statuses"] as? [[String:AnyObject]] else {
                    callback(response: nil)
                    return
                }
                
               callback(response: array)
                // 02 保存数据
                StatusDAL.saveCache(array)
                }, failure: { (error) in
                    print("数据请求失败\(error)")
                    callback(response: nil)
            })
        }
        
    }
    
    // MARK: - 用户查询
    class func getCache(sinceId:Int64,maxId:Int64) -> [[String:AnyObject]]?{
    
        /*
         CREATE TABLE IF NOT EXISTS "T_Status" (
         "statusid" INTEGER NOT NULL,
         "userid" INTEGER NOT NULL,
         "status" TEXT,
         "createtime" TEXT DEFAULT (datetime('now','localtime')),
         PRIMARY KEY("statusid","userid")
         )
         */
        //判断用户是否存在
        guard let userId = UserAccountViewModel.sharedModel.userInfo?.uid else { print("用户不存在")
            return nil
           }
        if sinceId <= 0 && maxId >= 0 {
        
            return nil
        }
        
        var sql = " select * from T_Status "
            sql += " where userid = \(userId) "
            if sinceId > 0 {
                   sql += "and statusid > \(sinceId) "
            }
        
            if maxId > 0{
                sql += " and statusid <= \(maxId) "

             }
        
            sql += " order by statusid desc "
            sql += " limit 20 "
        
        //查询出的均为二进制
        let result = SQLManager.sharedTools.selectSql(sql)
        var tempArray:[[String:AnyObject]] = [[String:AnyObject]]()
        for dic in result{
        
            let dics = try! NSJSONSerialization.JSONObjectWithData(dic["status"] as! NSData, options: []) as! [String:AnyObject]
            tempArray.append(dics)
        }
        
        return tempArray
        
        
    }
    
    class func saveCache(response:[[String: AnyObject]]){
    
        //用户uid
        guard let useId = UserAccountViewModel.sharedModel.userInfo?.uid else {
            print("用户没有登录")
            return
        }
       
        let sql = "insert or replace into T_Status (statusid,userid,status) values (?,?,?) "
        
        SQLManager.sharedTools.queue.inTransaction { (db, rollback) in
            for dic in response{
                
                //statusId
                let statusId = dic["id"] as! NSNumber
                let data = try! NSJSONSerialization.dataWithJSONObject(dic, options: [])
                let result = db.executeUpdate(sql, withArgumentsInArray: [statusId,useId,data])
                if result {
                    
                    print("成功")
                } else {
                    
                    print("失败")
                    //事务,错误回滚
                    rollback.memory = true
                }
            }
        }
    }
}
