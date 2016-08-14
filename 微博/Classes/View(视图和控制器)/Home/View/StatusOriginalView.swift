//
//  StatusOriginalView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/23.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SnapKit


//private var fsize :CGSize = CGSizeMake(0, 0)

class StatusOriginalView: UIView {
    
    var constraint :Constraint?
   
    var originaModel:UserCellViewModel?{
        
        didSet{
         
           profileImageView.sd_image(originaModel?.statuse?.user?.profile_image_url, placeName: "avatar_default")
            name.text = originaModel?.statuse?.user?.name
            memberImageView.image = originaModel?.memberImage
            timeLabel.text = NSDate.current(originaModel?.statuse?.created_at)?.currentDate
//                current(originaModel?.statuse?.created_at)
            source.attributedText = originaModel?.sourceAttr
            avatarImageView.image = originaModel?.avaterImage
            
            contentLabel.attributedText = originaModel?.originalEmoji
            
//            fsize = originaModel?.originalFigure ?? CGSizeMake(0, 0)
            
            
            
            self.constraint?.uninstall()
            //判断数据是否存在
            if let pic_urls = originaModel?.statuse?.pic_urls where pic_urls.count > 0 {
                //显示数据
                figureView.dataInfo = (pic_urls,originaModel!.originalPictureViewSize)
//               figureView.pic_urls = originaModel?.statuse?.pic_urls
                //更新布局
                self.snp_makeConstraints(closure: { (make) in
                   self.constraint = make.bottom.equalTo(figureView).offset(10).constraint
                })
                //显示
                figureView.hidden = false
                
            } else {
            
                //更新布局
                self.snp_makeConstraints(closure: { (make) in
                    self.constraint =  make.bottom.equalTo(contentLabel).offset(10).constraint

                })
                //隐藏
                figureView.hidden = true
            }
        }
    }
    
       // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  private  func setupUI(){
   
        backgroundColor = UIColor.whiteColor()
        addSubview(profileImageView)
        addSubview(name)
        addSubview(memberImageView)
        addSubview(timeLabel)
        addSubview(source)
        addSubview(avatarImageView)
        addSubview(contentLabel)
        addSubview(figureView)
    
    
        profileImageView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.size.equalTo(CGSizeMake(35, 35))
            
        }
        name.snp_makeConstraints { (make) in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp_right).offset(12)
            
         memberImageView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(name.snp_right).offset(12)
            make.centerY.equalTo(name)
         })
            
          timeLabel.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(profileImageView.snp_right).offset(10)
            make.bottom.equalTo(profileImageView)
          })
            
            source.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(timeLabel.snp_right).offset(10)
                make.bottom.equalTo(profileImageView)
            })
            
            avatarImageView.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(profileImageView.snp_trailing)
                make.centerY.equalTo(profileImageView.snp_bottom)
            })
            
            contentLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(profileImageView.snp_bottom).offset(10)
                make.leading.equalTo(profileImageView)
               
                
            })

            figureView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(contentLabel.snp_bottom).offset(10)
                make.leading.equalTo(contentLabel)
                
//                make.leading.equalTo((SCREENW - 3 * CGFloat(itemWith) - 2 * CGFloat(magin)) / 2)

                
            })
            self.snp_makeConstraints(closure: { (make) in
               self.constraint = make.bottom.equalTo(figureView).offset(10).constraint
            })
            
            
    }
    }
    // MARK: - 头像
    private lazy var profileImageView:UIImageView = UIImageView()
   
    // MARK: - 昵称
    private lazy var name:UILabel = {
        let name = UILabel(text: nil, textColor: UIColor.darkGrayColor(), textSize: 15)
       name.sizeToFit()
        return name
    }()
    // MARK: - 会员等级
    private lazy var memberImageView:UIImageView = UIImageView(imageName: "common_icon_membership")
    // MARK: - 发布时间
    private lazy var timeLabel:UILabel = UILabel(text: nil, textColor: ThemeColor, textSize: 10)
    // MARK: - 来源
    private lazy var source:UILabel = UILabel(text: nil, textColor: UIColor.darkGrayColor(), textSize: 10)
    // MARK: - 认证logo
    private lazy var avatarImageView:UIImageView = UIImageView(imageName: "avatar_vgirl")
    // MARK: - 内容
    private lazy var contentLabel:UILabel = UILabel(text: nil, textColor: UIColor.darkGrayColor(), textSize: 15,maxWidth: SCREENW - 20)
    // MARK: - 图片
    
    // MARK: - 下拉控件
    private lazy var figureView:StatusFigureView = StatusFigureView(frame: UIScreen.mainScreen().bounds, collectionViewLayout: UICollectionViewLayout())
    
}


