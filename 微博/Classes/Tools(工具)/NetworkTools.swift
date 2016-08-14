//
//  NetworkTools.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/22.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import AFNetworking

enum workType : String{
    
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {

    var success:((NSURLSessionDataTask, AnyObject?) -> Void)?
    var failure : ((NSURLSessionDataTask?, NSError) -> Void)?
//    var data:((Data:AnyObject?) -> Void)?
//    var error:((error:NSError) -> Void)?
    
    // MARK: - 单例
    static var sharedManage:NetworkTools = {
        let working = NetworkTools()
        working.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return working
        
    }()
// MARK: - 网络请求封装
    func workTools(type:workType,urlString:String,parameters:AnyObject?,success:((Data:AnyObject?) -> Void)?,failure:((error:NSError) -> Void)?){
        
        self.success = { (_, resposeData) in
            
            success?(Data: resposeData)
            
        }
        
        self.failure  = { (_, error) in
            
            failure?(error: error)
        }
        
        if type == .GET {
            
            self.GET(urlString, parameters: parameters, progress: nil, success: self.success, failure: self.failure)
            
        } else {
        
            self.POST(urlString, parameters: parameters, progress: nil, success: self.success, failure:self.failure)
        }
      
    }
    
   }

extension NetworkTools{
    
    // MARK: - 获取access_token:用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
    
    /*
     必选	类型及范围	说明
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    func accessUserInfo(code:String,success:((Data:AnyObject?) -> Void)?,failure:((error:NSError) -> Void)?){
        let pareameters = [
            
            "client_id":APPKEY,
            "client_secret":APPSECRET,
            "grant_type":"authorization_code",
            "code":code,
            "redirect_uri":APPREDIRECT_URI
        ]
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        workTools(.POST, urlString: urlString, parameters: pareameters, success: success, failure: failure)
    }

    // MARK: - 获取用户信息
    func UserInfo(access_token:String,uid:String,success:((Data:AnyObject?) -> Void)?,failure:((error:NSError) -> Void)?){
    
        let pareameters = [
            "access_token":access_token,
            "uid":uid,
        ]
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        workTools(.GET, urlString: urlString, parameters: pareameters, success: success, failure: failure)

    }
    
    // MARK: -获取当前登录用户及其所关注用户的最新微博
    
    func statuses(since_id:Int64,max_id:Int64,success:((Data:AnyObject?) -> Void)?,failure:((error:NSError) -> Void)?){
        
        let urlStrig = "https://api.weibo.com/2/statuses/home_timeline.json"
        /*
         since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
         max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
         */
        let dict = ["access_token":UserAccountViewModel.sharedModel.accessToken!,
                    "since_id":"\(since_id)",
                    "max_id":"\(max_id)"
        ]
       
        workTools(.GET, urlString: urlStrig, parameters: dict, success: success, failure: failure)
   
        
    }
}


//发布微博
extension NetworkTools {

    // MARK: - 上传文字
    func sendTextData(data:String,success:((Data:AnyObject?) -> Void)?,failure:((error:NSError) -> Void)?){
        
        let urlString = "https://api.weibo.com/2/statuses/update.json"
    
        let dict = [ "access_token":UserAccountViewModel.sharedModel.accessToken!,
                      "status":data
                    ]
        workTools(.POST, urlString: urlString, parameters: dict, success: success, failure: failure)
    
    }
    
    // MARK: - 上传文字及图片
    func sendTextImageLoad(status:String,images:[UIImage],success:((Data:AnyObject?) -> Void)?,failure:((error:NSError) -> Void)?){
    
        let urlSting = "https://upload.api.weibo.com/2/statuses/upload.json"
        let dict = [
        "access_token":UserAccountViewModel.sharedModel.accessToken!,
        "status":status
        ]
        
        POST(urlSting, parameters: dict, constructingBodyWithBlock: { (formData) in
          
          
            
            for i in 0..<images.count {
                
            let data = UIImagePNGRepresentation(images[i])!
         formData.appendPartWithFileData(data,name:"pic",fileName:"asfa",mimeType:"application/octet-stream")
            }
            
            }, success: { (_, responsData) in
                
                success?(Data: responsData)
                
            }) { (_, error) in
                failure?(error: error)
        }
    }
}
