//
//  EmoticonToolbar.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/29.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

enum EmoticonTool:Int {
    case defalut = 0,emoticob,lxh
}

@available(iOS 9.0, *)
class EmoticonToolbar: UIStackView {

    //表情按钮
    var currentBut:UIButton?
    //按钮点击传递
    var closure:((type:EmoticonTool) -> ())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // MARK: - 添加约束并设置约束
    func setupUI(){
       self.tag = 2000
        axis = .Horizontal
        distribution = .FillEqually
        addArrangedSubview(addButtone("left", title: "默认",type: .defalut))
        addArrangedSubview(addButtone("mid", title: "emoji",type: .emoticob))
        addArrangedSubview(addButtone("right", title: "浪小花",type: .lxh))
        
        
    }
    
    // MARK: - 初始化按钮
    func addButtone(imageName:String,title:String,type:EmoticonTool) -> UIButton{
    
        let but = UIButton()
        if type == .defalut {
            
            self.selectedBut(but)
            
        }
        but.tag = type.rawValue
        but.addTarget(self, action:#selector(EmoticonToolbar.btnClick(_:)), forControlEvents: .TouchUpInside)
        but.setBackgroundImage(UIImage(named: "compose_emotion_table_\(imageName)_normal"), forState: .Normal)
        but.setBackgroundImage(UIImage(named: "compose_emotion_table_\(imageName)_selected"), forState: .Selected)
        but.setTitle(title, forState: .Normal)
        but.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        but.setTitleColor(UIColor.darkGrayColor(), forState: .Selected)
        but.titleLabel?.font = UIFont.systemFontOfSize(15)
        return but
    }
    
    // MARK: - 滚动调用的方法,通外界调用
    func scrollViewBut(tag:Int){
        
        //注意:viewWith返回的空间,如果tag值等于调用者的tag值,默认返回条用者,这里返回为EmoticonToolbar不能转为UIButton
    
       let button = viewWithTag(tag) as! UIButton
     
        selectedBut(button)
    }
    // MARK: - 点击调用的方法
    func btnClick(button:UIButton){
    
       selectedBut(button)
        
        closure?(type: EmoticonTool(rawValue: button.tag)!)
        
    }

    // MARK: - 设置选中按钮的状态
    func selectedBut(button:UIButton){
        if  currentBut == button {
            return
        }
        button.selected = true
        currentBut?.selected = false
        currentBut = button
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
