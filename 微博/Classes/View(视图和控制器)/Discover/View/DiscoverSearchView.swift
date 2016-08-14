//
//  DiscoverSearchView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/23.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class DiscoverSearchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, SCREENW, 35))
        setupUI()
        self.textField.backgroundColor = UIColor.whiteColor()
    }
    
    func setupUI(){
        backgroundColor = RandomColor()
        self.addSubview(button)
        self.addSubview(textField)
        
        button.snp_makeConstraints { (make) in
            make.right.equalTo(self)
            make.width.equalTo(50)
            make.centerY.equalTo(self)
            make.height.equalTo(self)
        }
        
        textField.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(self)

        }
        
       
    }
    
    lazy var textField:UITextField = {
    
        let tf = UITextField()
         let imageView = UIImageView(image: UIImage(named: "searchbar_textfield_search_icon"))
        imageView.frame.size = CGSizeMake(35, 35)
        imageView.contentMode = UIViewContentMode.Center
        
        tf.leftView = imageView
        tf.leftViewMode = UITextFieldViewMode.Always
        tf.placeholder = "请输入搜索内容"
        
        tf.layer.borderColor = ThemeColor.CGColor
        tf.layer.borderWidth = 2
        tf.delegate = self
        return tf
        
    }()
    
    lazy var button:UIButton = {
    
        let button:UIButton = UIButton()
        button.setTitleColor(ThemeColor, forState: .Normal)
        button.setTitle("取消", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
       
        button.addTarget(self, action: #selector(DiscoverSearchView.btnClick), forControlEvents: .TouchUpInside)
        return button
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func btnClick() {
        textField.snp_updateConstraints { (make) in
            make.right.equalTo(self)
        }
        
        UIView.animateWithDuration(0.2, animations: { 
            self.layoutIfNeeded()
            }) { (_) in
           self.textField.resignFirstResponder()
        }
        
    }
}
extension DiscoverSearchView:UITextFieldDelegate{

    func textFieldDidBeginEditing(textField: UITextField) {
        
        textField.snp_updateConstraints { (make) in
            make.right.equalTo(self).offset(-50)
            make.top.bottom.left.equalTo(self)
        }
        UIView.animateWithDuration(0.2) { 
            self.layoutIfNeeded()
        }

    }

}