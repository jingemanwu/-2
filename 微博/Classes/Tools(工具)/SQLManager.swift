//
//  SQLManager.swift
//  微博
//
//  Created by 牛晴晴 on 16/8/1.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
private let dbName = "shstatus.db"

class SQLManager: NSObject {
    
    static let sharedTools:SQLManager = SQLManager()
   
    let queue:FMDatabaseQueue
    
   override init() {
    
    let path = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString).stringByAppendingPathComponent(dbName)

    //如果有数据库,就打开,没有就创建
     queue = FMDatabaseQueue(path: path)
    super.init()
    // 创建表
    createTable()
   
    }
    
    func createTable(){
    
        let sqlTable = NSBundle.mainBundle().pathForResource("db.sql", ofType: nil)!
      
        //准备sql
        let sql = try! String(contentsOfFile:sqlTable)
        
        queue.inDatabase { (db) in
           let result = db.executeStatements(sql)
            if result {
            
                print("创建表成功")
            } else {
            
                print("创建表失败")
            }
        }
        
    }
   
    func selectSql(sql:String) -> ([[String:AnyObject]]) {
    
        var temp:[[String:AnyObject]] = [[String:AnyObject]]()
        queue.inDatabase { (db) in
            
           let result = db.executeQuery(sql, withArgumentsInArray: nil)
            
            while result.next() {
            
                var dict:[String:AnyObject] = [String:AnyObject]()
                
                for i in 0..<result.columnCount(){
                
                    let key = result.columnNameForIndex(i)
                    let value = result.objectForColumnIndex(i)
                    dict[key] = value
                    
                }
                temp.append(dict)
            }
            
        }
    return temp
        
    }
    
   
}
