//
//  MainViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    
    
    lazy var tab:TabBarView = TabBarView(frame:UIScreen.mainScreen().bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    view.backgroundColor = UIColor.whiteColor()
        addChildViewControllers()
     tabBar.addSubview(tab)
        tab.tabBarBlock = { [weak self] in
        let com:CommposeView = CommposeView()
            com.showInfo(self!)
        }
        
     setValue(tab, forKey: "tabBar")
    }

//    private lazy var com:CommposeView = CommposeView()

}
// MARK: - 添加控制器
extension MainViewController{
    
    func addChildViewControllers() {
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
          addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
          addChildViewController(DiscoverViewController(), title: "关于", imageName: "tabbar_discover")
          addChildViewController(ProfileViewController(), title: "我", imageName: "tabbar_profile")
    }

    func addChildViewController(vc:UIViewController,title:String,imageName:String) {
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)?.imageWithRenderingMode(.AlwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        //设置字体颜色
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:ThemeColor], forState: .Selected)
        
        let na = UINavigationController(rootViewController: vc)
        addChildViewController(na)
    }
}
