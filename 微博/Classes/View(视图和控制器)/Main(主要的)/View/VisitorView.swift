//
//  VisitorView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SnapKit


class VisitorView: UIView {

    var butBlock:(()->())?
    
  override  init(frame: CGRect) {
        super.init(frame: frame)
    
       setupUI()
     self.backgroundColor = UIColor(red: 237 / 255, green: 235 / 255, blue: 237 / 255, alpha: 1)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewText(title:String?,imageName:String?){
    
        if let ti = title , let im = imageName {
            
            house.image = UIImage(named:im)
            textLabel.text = ti
            feedView.hidden = true
            
        }
        else{
            
         setBase()
            
        }
        
        
    }
    
    func setBase(){
     
        let ani = CABasicAnimation(keyPath: "transform.rotation")
        ani.removedOnCompletion = false
        ani.toValue = M_PI * 2
        ani.duration = 5
        ani.repeatCount = MAXFLOAT
        feedView.layer.addAnimation(ani, forKey: nil)
    }
    func setupUI(){
    
        self.addSubview(feedView)
        self.addSubview(smalicon)
        self.addSubview(house)
        self.addSubview(textLabel)
        self.addSubview(loninButton)
        self.addSubview(regButton)
        
         feedView.snp_makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.centerY.equalTo(self)
         }
        
         smalicon.snp_makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
         }
        
        house.snp_makeConstraints { (make) in
            make.centerY.centerX.equalTo(self)
        }
        
        textLabel.snp_makeConstraints { (make) in
            make.top.equalTo(feedView.snp_bottom).offset(20)
            make.centerX.equalTo(feedView)
            make.width.equalTo(237)
        }
        
        loninButton.snp_makeConstraints { (make) in
            make.left.equalTo(textLabel)
            make.top.equalTo(textLabel.snp_bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        regButton.snp_makeConstraints { (make) in
            make.trailing.equalTo(textLabel)
            make.top.equalTo(textLabel.snp_bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
            
        }
    }
    
    lazy var feedView:UIImageView = {
        
        let fe = UIImageView(imageName: "visitordiscover_feed_image_smallicon")

        return fe
        
    }()
    
    lazy var smalicon:UIImageView = {
        let smal = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")
        return smal
    }()
    
    lazy var house:UIImageView = {
        
        let hou = UIImageView(imageName: "visitordiscover_feed_image_house")
        return hou
    }()

    lazy var textLabel:UILabel = {
        let te = UILabel(text: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜", textColor: UIColor.grayColor(), textSize: 14)
        
        te.numberOfLines = 0
        te.textAlignment = NSTextAlignment.Center

        return te
    }()
    
     func btnClick(){
     
        butBlock?()
        
    }
    lazy var loninButton:UIButton = {
        let button = UIButton()
       
        button.addTarget(self, action: #selector(VisitorView.btnClick), forControlEvents: .TouchUpInside)
        button.setBackgroundImage( UIImage(named: "common_button_white_disable"), forState: .Normal)
        button.setTitle("登录", forState: .Normal)
        button.setTitleColor(ThemeColor, forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        return button
    }()
    
    lazy var regButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(VisitorView.btnClick), forControlEvents: .TouchUpInside)
        
        button.setBackgroundImage( UIImage(named: "common_button_white_disable"), forState: .Normal)
        button.setTitle("注册", forState: .Normal)
        button.setTitleColor(ThemeColor, forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        return button
    }()

}
