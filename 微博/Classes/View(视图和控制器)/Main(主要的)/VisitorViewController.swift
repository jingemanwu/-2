//
//  VisitorViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class VisitorViewController: UIViewController {
    
    let loinType:Bool = UserAccountViewModel.sharedModel.userInfo?.access_token != nil
    var visitorView:VisitorView?
    
    override func loadView() {
        
         loinType ? (view = tableView) : setup()
        
    }
   
    
    func setup(){
            
        visitorView = VisitorView()
        visitorView?.butBlock = { [weak self] in
           
            self?.btnClick()
        }
        view = visitorView
        setNav()
    }
    func btnClick(){
        let nav = UINavigationController(rootViewController: OAuthViewController())
        presentViewController(nav, animated:true, completion: nil)
    }
    
    func setNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VisitorViewController.btnClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(titles: "注册", images: nil, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VisitorViewController.btnClick))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    
    lazy var tableView:UITableView = UITableView()
    

}
