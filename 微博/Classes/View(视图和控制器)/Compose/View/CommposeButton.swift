//
//  CommposeButton.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/28.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class CommposeButton: UIButton {

    
    var model:ComposeModel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
    
        self.titleLabel?.textAlignment = .Center
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.contentMode = .Center

    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        backgroundColor = UIColor.blueColor()
        self.imageView?.frame = CGRectMake(0, 0, self.frame.width, self.frame.width)
        self.titleLabel?.frame = CGRectMake(0, self.frame.width, self.frame.width, self.frame.height - self.frame.width)
            }
    
    override var highlighted: Bool{
    
        get{
        
            return false
        }
        
        set{
        
        }
    }

}
