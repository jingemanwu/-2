//
//  UserStatuseModel.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/23.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SDWebImage

class UserStatuseModel: NSObject {

    var listData:[UserCellViewModel] = [UserCellViewModel]()
    
    func userStatuse(isPullUp:Bool,isSucces:(issucces:Bool,count:Int) -> ()){
        
        var maxID:Int64 = 0
        var sinceId:Int64 = 0
        //isPullUp 上拉
        if isPullUp {
            
            maxID = listData.last?.statuse?.id ?? 0
             // 因为服务器返回来重复数据 需要程序员自己处理
            if maxID > 0 {
            
                maxID -= 1
            }
        } else {
        
            sinceId = listData.first?.statuse?.id ?? 0
        }
        
        StatusDAL.checkCache(sinceId, maxId: maxID) { (response) in
            guard let array = response else {
//                print("请求错误\(error)")
                isSucces(issucces: false,count:0)
                return }

            
                var tempArray:[UserCellViewModel] = [UserCellViewModel]()
                for dict in array {
                    
                    let userStatu = UserStatuse(dict: dict)
                    let userViewModel = UserCellViewModel(statuse: userStatu)
                    
                    tempArray.append(userViewModel)
                }
                
                if isPullUp {
                    
                    self.listData +=  tempArray
                    self.cachSingleImage(tempArray, isSucces:isSucces,isPullUp:true)
//                    isSucces(issucces: true,count:-1)
                    
                    
                } else {
                    
                    self.listData = tempArray + self.listData
                    self.cachSingleImage(tempArray, isSucces:isSucces,isPullUp:false)
                    
//                    isSucces(issucces: true,count:tempArray.count)
                }
            
            //　缓存单张图片
            
  
        }
        
       }
    //缓存单张图片
    private func cachSingleImage(tempArray:[UserCellViewModel],isSucces:(issucces:Bool,count:Int) -> (),isPullUp:Bool){
        
        let group = dispatch_group_create()
        for value in tempArray {
            //1.遍历判断图片数组是否是单张
            
            //是去原创微博的图片,还是转发微博的图片
            let originalPicUrls = value.statuse?.pic_urls
            let retweetPicurls = value.statuse?.retweeted_status?.pic_urls
            
            //取到图片数组
            let picUrls = (originalPicUrls == nil || originalPicUrls!.count == 0 ) ? retweetPicurls : originalPicUrls
            
            if picUrls?.count == 1 {
                
                //取到下载地址
                let  urlString =  picUrls?.first?.thumbnail_pic
                
                //放一个鸡蛋
                dispatch_group_enter(group)
                
                //2.去下载
                //缓存图片的时候是以图片的地址进行MD5加密之后的字符串作为图片的文件名
                SDWebImageManager.sharedManager().downloadImageWithURL(NSURL(string: urlString ?? ""), options: [], progress: nil, completed: { (image, error, _, _, _) in
                    //3.监听下载完成
                    //更新单张图片的配图视图大小
                    value.updateSingleImagePictureViewSize()
                    //拿出一个鸡蛋
                    dispatch_group_leave(group)
                })                
                
            }
       }
        //4.所有单张图片的下载完成通知
        dispatch_group_notify(group, dispatch_get_main_queue()) {
            if isPullUp {
                isSucces(issucces: true,count:-1)
            } else {
               isSucces(issucces: true,count:tempArray.count)
            }
            
        }
    }

}
