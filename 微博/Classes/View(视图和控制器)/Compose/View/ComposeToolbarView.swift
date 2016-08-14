//
//  ComposeToolbarView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/27.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

enum ComposeToolbarViewType:Int {
    //图片
    case Picture = 1001
    //@
    case Mention = 1002
    //#
    case Trend = 1003
    //标签
    case Emoticon = 1004
    //+
    case Add = 1005
}
class ComposeToolbarView: UIView {
    //表情按钮
    var emoticonButton:UIButton?
    //是否是表情键盘
    var isEmoticon:Bool = false{
        
        didSet{
            //true当前是表情图片,切换button的image是键盘图片
            let imgName = isEmoticon ? "compose_keyboardbutton_background" : "compose_emoticonbutton_background"
            emoticonButton?.setImage(UIImage(named: imgName), forState: .Normal)
            emoticonButton?.setImage(UIImage(named: "\(imgName)_highlighted"), forState: .Highlighted)
            
            
            
        }
    }
    var compost:((type:ComposeToolbarViewType) -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func  setupUI(){
    
        let pictureButton = addChildButton("compose_toolbar_picture", type: .Picture)
        let mentionButton = addChildButton("compose_mentionbutton_background", type: .Mention)
        let trendButton = addChildButton("compose_trendbutton_background", type: .Trend)
        emoticonButton = addChildButton("compose_emoticonbutton_background", type: .Emoticon)
        let addButton = addChildButton("compose_add_background", type: .Add)
        pictureButton.snp_makeConstraints { (make) in
            make.top.leading.bottom.equalTo(self)
            make.width.equalTo(mentionButton)
            
        }
        mentionButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.equalTo(trendButton)
            make.leading.equalTo(pictureButton.snp_trailing)
        }
        
        trendButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.equalTo(emoticonButton!)
            make.leading.equalTo(mentionButton.snp_trailing)
        }
        emoticonButton!.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.equalTo(addButton)
            make.leading.equalTo(trendButton.snp_trailing)
        }
        addButton.snp_makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(self)            
            make.leading.equalTo(emoticonButton!.snp_trailing)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func btnClick(but:UIButton){
       
        compost?(type: ComposeToolbarViewType(rawValue: but.tag)!)
        
    }
    func addChildButton(imageName:String,type:ComposeToolbarViewType) -> UIButton{
    
        let but = UIButton()
        but.tag = type.rawValue
        but.addTarget(self, action: #selector(ComposeToolbarView.btnClick(_:)), forControlEvents: .TouchUpInside)
        but.setImage(UIImage(named: imageName), forState: .Normal)
        but.setImage(UIImage(named: "\(imageName)_highlighted"), forState: .Highlighted)
        but.setBackgroundImage(UIImage(named: "compose_toolbar_background"), forState: .Normal)
          but.setBackgroundImage(UIImage(named: "compose_toolbar_background"), forState: .Highlighted)
        addSubview(but)
        return but
        
    }
}
