//
//  DiscoverViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class DiscoverViewController: VisitorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !loinType {
            
            visitorView?.setViewText("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imageName: "visitordiscover_image_message")
            
        }
        
        self.navigationItem.titleView = DiscoverSearchView()
    }

   
}
