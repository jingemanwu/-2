//
//  StatusRetweetView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/24.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SnapKit

class StatusRetweetView: UIView {
    private var constraint:Constraint?
    var retModel:UserCellViewModel?{
    
        didSet{
        
            retweet.attributedText = retModel?.retweetEmoji
            
            self.constraint?.uninstall()
            if let pic_urls = retModel?.statuse?.retweeted_status?.pic_urls where pic_urls.count > 0 {
            
                figureView.dataInfo = (pic_urls,retModel!.retweetPictureViewSize)
                self.snp_makeConstraints(closure: { (make) in
                    self.constraint = make.bottom.equalTo(figureView).offset(10).constraint
                })
                
                figureView.hidden = false
                
            } else {
            
                self.snp_makeConstraints(closure: { (make) in
                    self.constraint = make.bottom.equalTo(retweet).offset(10).constraint
                })
                figureView.hidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRetweetUI()
    }
    func setRetweetUI(){
        backgroundColor = RGB(237, green: 237, blue: 237)
        addSubview(retweet)
        addSubview(figureView)
        retweet.snp_makeConstraints { (make) in
            make.top.leading.equalTo(10)
        }
        figureView.snp_makeConstraints { (make) in
            make.top.equalTo(retweet.snp_bottom).offset(10)
            make.leading.equalTo(retweet)
//            make.leading.equalTo((SCREENW - 3 * CGFloat(itemWith) - 2 * CGFloat(magin)) / 2)
        }
        self.snp_makeConstraints { (make) in
          self.constraint = make.bottom.equalTo(figureView).offset(10).constraint
        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var retweet:UILabel = UILabel(text: nil, textColor: UIColor.darkGrayColor(), textSize: 15, maxWidth: SCREENW - 20)
    
    private lazy var figureView:StatusFigureView = StatusFigureView()
}
