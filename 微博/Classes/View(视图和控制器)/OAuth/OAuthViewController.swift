//
//  OAuthViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/20.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    
    
    override func loadView() {
        //https://api.weibo.com/oauth2/authorize?client_id=3449423477&redirect_uri=http://www.baidu.com/
        let path = "https://api.weibo.com/oauth2/authorize?client_id=\(APPKEY)&redirect_uri=\(APPREDIRECT_URI)"
       let url = NSURL(string: path)
        print(path)
        guard let u = url else {
        
            return
        }
        let request = NSURLRequest(URL: u)
        
        webView.loadRequest(request)
        webView.delegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        view.backgroundColor = UIColor.whiteColor()
        setupUI()
    }
    
    func setupUI(){
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(OAuthViewController.btnClick))
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(OAuthViewController.ValueChanage))
        
        navigationController?.view.insertSubview(ProgressView, belowSubview: navigationController!.navigationBar)
        
        self.title = "微博登录"
    }
    
    func ValueChanage(){
    
        let jsString = "document.getElementById('userId').value='\(wbName)',document.getElementById('passwd').value='\(wbPasswd)'"
        webView.stringByEvaluatingJavaScriptFromString(jsString)
    }
    func btnClick(){
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    lazy var webView:UIWebView = UIWebView()
    lazy var ProgressView:OAuthView = OAuthView()
    
}
extension OAuthViewController:UIWebViewDelegate{

    func webViewDidStartLoad(webView: UIWebView) {
        ProgressView.start()
        SVProgressHUD.show()
    }
    //记载失败
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        ProgressView.endAnim()
        SVProgressHUD.dismiss()
    }
    //请求加载,将要加载的request
     /*
      1.有返回值
      - 如果为true  代表继续记载
    - false 闭包停止加载
     - 默认如果不实现该放发,默认为true
     */
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.URL?.absoluteString
        SVProgressHUD.dismiss()
        if let u = url where u.hasPrefix(APPREDIRECT_URI){
        
            //请求参数
            let query = request.URL?.query
            if let q = query {
            
               let code = q.substringFromIndex("code=".endIndex)
                UserAccountViewModel.sharedModel.accessUserInfoModel(code, isSuccess: { (isSucces:Bool) in
                    if !isSucces {
                    
                        return
                    }
                    self.dismissViewControllerAnimated(false, completion: {
                 NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootViewControllerNoti, object: nil)
                        
                    })
                    print("用户已登录")
                
               })
            }
            return false
        }
        
        return true
    }
    
    
}
