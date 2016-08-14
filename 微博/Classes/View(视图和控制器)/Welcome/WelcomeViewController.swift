//
//  WelcomeViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/22.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
   
    override func loadView() {
        view = bgimageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(animated: Bool) {
        
        touImageView.snp_updateConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(view)
            make.height.width.equalTo(90)
        }

        ///  动画
        ///1,动画时间2,延迟多长时间3.阻尼,阻尼越大,动画移动的越慢,4.加速度5,参数
        ///  - returns: <#return value description#>
        UIView.animateWithDuration(3, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            
                self.view.layoutIfNeeded()
            
            }) { (Bool) in
                
                UIView.animateWithDuration(0.25, animations: { 
                    
                   self.meanageText.alpha = 1
                }, completion: { (_) in
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootViewControllerNoti, object: "root")
                })

               
        }
    }
    func setupUI(){
    
        view.addSubview(touImageView)
        view.addSubview(meanageText)
        touImageView.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(400)
            make.centerX.equalTo(view)
            make.width.height.equalTo(90)
        }
        meanageText.snp_makeConstraints { (make) in
            make.top.equalTo(touImageView.snp_bottom).offset(20)
            make.centerX.equalTo(view)
        }
    }
    
    lazy var touImageView:UIImageView = {
    
        let imageview:UIImageView = UIImageView()
        
        imageview.sd_image(UserAccountViewModel.sharedModel.userInfo?.avatar_large, placeName: "avatar_default_big")
        imageview.layer.borderColor = ThemeColor.CGColor
        imageview.layer.borderWidth = 2
        imageview.layer.cornerRadius = 45
        imageview.layer.masksToBounds = true
        
        return imageview
    }()
    
    lazy var meanageText:UILabel = {
    
        let label:UILabel = UILabel(text: "欢迎体验", textColor: UIColor.darkGrayColor(), textSize: 17)
        label.textAlignment = .Center;
        label.alpha = 0
        return label
    }()
    lazy var bgimageView:UIImageView = UIImageView(imageName: "ad_background")

}
