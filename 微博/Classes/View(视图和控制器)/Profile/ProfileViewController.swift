//
//  ProfileViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class ProfileViewController: VisitorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !loinType {
            
            visitorView?.setViewText("登录后，你的微博、相册、个人资料会显示在这里，展示给别人", imageName: "visitordiscover_image_profile")
            
        }
    }

   
}
