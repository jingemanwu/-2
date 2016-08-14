//
//  ComposeTextView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/27.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {
//    var blockType:((type:Bool) -> ())?
    
    override var font: UIFont?{
        didSet{
            self.placeholderLabel.font = font
        }
        
    }

    var textPlace:String?{
    
        didSet{
        
            self.placeholderLabel.text = textPlace
        }
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        addSubview(placeholderLabel)
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint( item: placeholderLabel, attribute: .Leading, relatedBy: .Equal , toItem: self, attribute: .Leading, multiplier: 1, constant: 5 ))
        addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: -10))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeTextView.valueChanage), name: UITextViewTextDidChangeNotification, object: nil)
    
    }
    func valueChanage(){
    
        placeholderLabel.hidden = self.hasText()
//        blockType?(type:self.hasText())
    }
    lazy var placeholderLabel:UILabel = {
    
        let la:UILabel = UILabel()
        la.textColor = UIColor.grayColor()
        la.numberOfLines = 0
        la.sizeToFit()
        return la
    }()
}
