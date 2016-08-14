//
//  StautsCell.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/23.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SnapKit

//let itemWith = 80
//let magin = 10

// cell里面公共的间距
let StatusCellMargin: CGFloat = 8

class StautsCell: UITableViewCell {

    var toolBarBottomConstraint:Constraint?
    
    
    var cellModel:UserCellViewModel?{
    
        didSet{
        
            original.originaModel = cellModel
            let result = cellModel?.statuse?.retweeted_status
            print("微博转发\(result)")
            
            /*
             - 首先要先卸载底部视图的顶部约束
             - 如果retweeted_status == nil 代表没有转发微博
             - 底部视图的top ==  原创微博的bottom
             - 隐藏转发微博
             - 反之 就是有转发微博
             - 给转发微博的ViewModel 赋值
             - 底部视图的top ==  转发微博的bottom
             - 显示转发微博
             */
        self.toolBarBottomConstraint?.uninstall()
            
            if cellModel?.statuse?.retweeted_status == nil {
              
                self.toolBar.snp_updateConstraints(closure: { (make) in
                      self.toolBarBottomConstraint = make.top.equalTo(original.snp_bottom).constraint
                })
               
                  self.retweet.hidden = true
                
            } else{
               
                retweet.retModel = cellModel
                
                self.toolBar.snp_updateConstraints(closure: { (make) in
                    
                     self.toolBarBottomConstraint =  make.top.equalTo(retweet.snp_bottom).constraint
                })
                 self.retweet.hidden = false
            }
            toolBar.toolBar = cellModel
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellUI()
//         backgroundColor = RandomColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }

    func setCellUI(){
        backgroundColor = RGB(237, green: 237, blue: 237)
        contentView.addSubview(original)
        contentView.addSubview(retweet)
        contentView.addSubview(toolBar)
        
        original.snp_makeConstraints { (make) in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(contentView).offset(30)
        }
        retweet.snp_makeConstraints { (make) in
            make.top.equalTo(original.snp_bottom)
            make.leading.trailing.equalTo(contentView)
            
        }
        toolBar.snp_makeConstraints { (make) in
          self.toolBarBottomConstraint =
            make.top.equalTo(retweet.snp_bottom).constraint
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(35)
        }
     
        contentView.snp_makeConstraints { (make) in
            make.leading.trailing.top.equalTo(self)
            make.bottom.equalTo(toolBar)
        }
        
    }
    
    private lazy var original:StatusOriginalView = StatusOriginalView()
    private lazy var toolBar:StatusToolBarView = StatusToolBarView()
    private lazy var retweet:StatusRetweetView = StatusRetweetView()
    
}
