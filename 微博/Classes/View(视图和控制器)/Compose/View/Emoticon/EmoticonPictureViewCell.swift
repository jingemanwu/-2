//
//  EmoticonPictureViewCell.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/29.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit



class EmoticonPictureViewCell: UICollectionViewCell {
    
    var buttons:[EmoticonPictureButton] = [EmoticonPictureButton]()
    var emoticon:[Emoticon]?{
    
        didSet{
        
            guard let emoticon = emoticon else { return }
            for  (i,value) in emoticon.enumerate() {
                let button:EmoticonPictureButton = buttons[i]
                button.hidden = false
                button.emoticon = value

            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
       
    }
    func setupUI(){
        
        addButton()
        let width =  (SCREENW - 10) / CGFloat(colm)
        let heigth = (self.frame.height - 20) / CGFloat(row)
        for (i,value) in buttons.enumerate() {
            let rowX = CGFloat(i / colm)
            let colmY = CGFloat(i % colm)
            
            value.frame = CGRect(x:colmY * width + 5 , y: rowX * heigth , width: width, height: heigth - 10)
        }
        addSubview(butt)
        butt.frame = CGRect(x: SCREENW - 5 - width, y: self.frame.height - 25 - heigth, width: width, height: heigth)
        
        //给contenView添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(EmoticonPictureViewCell.longPress(_:)))
        //最短的触发时间
        longPress.minimumPressDuration = 3
        contentView.addGestureRecognizer(longPress)

    }
    
    
    // MARK: - 长按显示popView事件
   @objc private func longPress(ges:UILongPressGestureRecognizer){
    
        //1.取到手指所在的位置
        let location = ges.locationInView(ges.view)
        
        //2.找到该位置所对应的按钮
        func buttonWithLocation(location: CGPoint) -> EmoticonPictureButton?{
        
            for value in buttons {
                //if value的范围是否包含传入的点，如果包含，直接返回value
                if CGRectContainsPoint(value.frame, location){
                
                    return value
                }
            }
            return nil
        }
    
        //通过点找到点对应的表情按钮
         guard let button = buttonWithLocation(location) else {
                popView.removeFromSuperview()
                return
            }
    
        switch ges.state {
            case .Began,.Changed:
                
                if popView.emoticonButton.emoticon == button.emoticon{
                
                    return
                }
                let window = UIApplication.sharedApplication().windows.last
                let rect = button.convertRect(button.bounds, toView: window)
                //中心点一样
                popView.center.x = CGRectGetMidX(rect)
                popView.frame.origin.y = CGRectGetMaxY(rect) - popView.frame.height
                //给popView里面的按钮赋值
                popView.emoticonButton.emoticon = button.emoticon
                //3.添加
                window?.addSubview(popView)
                
            default:
                popView.removeFromSuperview()
            }
    }
    // MARK: - 点击表情发通知
    func btnClick(btn:EmoticonPictureButton){
        
        NSNotificationCenter.defaultCenter().postNotificationName(EmoticonPictureClick, object: btn.emoticon)
        
        //0.取到最上层的window
        let window = UIApplication.sharedApplication().windows.last
        
        //1.初始化一个popView
        let popView = EmoticonPopView.popView()
        
        //2.坐标转换:将按钮在contentView里面的坐标值转换到window上面

        let rect = btn.superview!.convertRect(btn.frame, toView: window)
        
//        中心点一样
        popView.center.x = CGRectGetMidX(rect)
        popView.frame.origin.y = CGRectGetMaxY(rect) - popView.frame.height
        
        //给popView里面的按钮赋值
        popView.emoticonButton.emoticon = btn.emoticon
        
        //3.添加
        window?.addSubview(popView)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            popView.removeFromSuperview()
        }
    }
    // MARK: - 定义一个方法,添加按钮到数组中
    func addButton(){
        
        for _ in 0...palineMax {
            let button:EmoticonPictureButton = EmoticonPictureButton()
            button.addTarget(self, action: #selector(EmoticonPictureViewCell.btnClick(_:)), forControlEvents: .TouchUpInside)
            contentView.addSubview(button)
            button.hidden = true
            button.backgroundColor = self.backgroundColor
            button.titleLabel?.font = UIFont.systemFontOfSize(30)
            buttons.append(button)
            
        }
       
        
    }

   // MARK: - 删除按钮
    func deleteClick(){
    
        NSNotificationCenter.defaultCenter().postNotificationName(EmoticonDeleteClick, object: nil)
        
    }
    
    private lazy var butt:UIButton = {
    
        let button = UIButton()
        button.addTarget(self, action: #selector(EmoticonPictureViewCell.deleteClick), forControlEvents: .TouchUpInside)
        button.setImage(UIImage(named:"compose_emotion_delete_highlighted"), forState: .Highlighted)
        button.setImage(UIImage(named:"compose_emotion_delete"), forState: .Normal)
        return button
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //长按出现的popView
    private lazy var popView:EmoticonPopView = {
    
        let popView = EmoticonPopView.popView()
        return popView
    }()
}
