//
//  TabBarView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class TabBarView: UITabBar {

    var tabBarBlock:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   override func layoutSubviews() {
        super.layoutSubviews()
    let width = frame.width * 0.2
    var index:CGFloat = 0
    for value in subviews {
        
        if value.isKindOfClass(NSClassFromString("UITabBarButton")!) {
            value.frame.origin.x = width * index
            index++
            if index == 2 {
                index++
            }
        }
       
        
    }
}
    func btnClick(){
        tabBarBlock?()
    }
    func setupUI(){
    
        let button = UIButton()
        button.addTarget(self, action: #selector(TabBarView.btnClick), forControlEvents: .TouchUpInside)
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        button.sizeToFit()
        
        self.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }

}
