//
//  StatusToolBarView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/24.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class StatusToolBarView: UIView {
    var retweetButton:UIButton?
    var commentButton:UIButton?
    var unlikeButton:UIButton?
    var toolBar:UserCellViewModel?{
    
        didSet{
        
            retweetButton?.setTitle(toolBar?.repostsCountStr, forState: .Normal)
            commentButton?.setTitle(toolBar?.commentsCountStr, forState: .Normal)
            unlikeButton?.setTitle(toolBar?.attitudesCountStr, forState: .Normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setToolUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func  setToolUI(){
        self.backgroundColor = RGB(237, green: 237, blue: 237)
        retweetButton = button("timeline_icon_retweet", text: "转发")
        commentButton = button("timeline_icon_comment", text: "评论")
        unlikeButton = button("timeline_icon_unlike", text: "赞")
        let image1 = linUI()
        let image2 = linUI()
        
        retweetButton?.snp_makeConstraints { (make) in
            
            make.top.leading.bottom.equalTo(self)
            make.width.equalTo(commentButton!)

        }
        
        commentButton?.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(retweetButton!.snp_trailing)
            make.width.equalTo(unlikeButton!)
        }
        
        unlikeButton?.snp_makeConstraints { (make) in
            
            make.top.trailing.bottom.equalTo(self)
            make.leading.equalTo(commentButton!.snp_trailing)
            
        }
        image1.snp_makeConstraints { (make) in
            make.centerX.equalTo(retweetButton!.snp_trailing)
            make.centerY.equalTo(self)
        }
        image2.snp_makeConstraints { (make) in
            make.centerX.equalTo(commentButton!.snp_trailing)
            make.centerY.equalTo(self)
        }
        
    }
    
    func button(imageName:String,text:String) -> UIButton{
    
        let but:UIButton = UIButton()
        but.setImage(UIImage(named: imageName), forState: .Normal)
        but.setTitle(text, forState: .Normal)
        but.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        but.titleLabel?.font = UIFont.systemFontOfSize(15)
        but.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: .Normal)
        but.setBackgroundImage(UIImage(named: "timeline_card_bottom_background_highlighted"), forState: .Highlighted)
        addSubview(but)
        return but
    }
    
    func linUI() -> UIImageView{
        
        let imageView = UIImageView(imageName: "timeline_card_bottom_line")
        addSubview(imageView)
        return imageView
    }
}
