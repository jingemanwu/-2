//
//  MessageViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class MessageViewController: VisitorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !loinType {
            
            visitorView?.setViewText("登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", imageName: "visitordiscover_image_message")
            
        }
    }

    }
