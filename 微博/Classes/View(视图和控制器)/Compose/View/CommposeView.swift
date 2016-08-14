//
//  CommposeView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/28.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import pop

private let width:CGFloat = 80.0
private let height:CGFloat = 110.0
class CommposeView: UIView {
    var buttons:[CommposeButton] = [CommposeButton]()
    var dataList:[ComposeModel] = [ComposeModel]()
    var target:UIViewController?
    
    func showInfo(target:UIViewController){
        self.target = target
        target.view.addSubview(self)
        anminAction(true)
    }
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, SCREENW, SCREENH))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
       
        backgroundColor = UIColor.blueColor()
        addSubview(imageView)
        addSubview(imageTitle)
        composeButton()
        imageTitle.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(100)
        }
       
        

    }
    func compostModel(){
    
        let path = NSBundle.mainBundle().pathForResource("compose.plist", ofType: nil)!
        
        let array = NSArray(contentsOfFile: path)!
        var tempList:[ComposeModel] = [ComposeModel]()
        for dict in array {
            
            let model:ComposeModel = ComposeModel(dict: dict as! [String : AnyObject])
            tempList.append(model)
        }
        
       dataList = tempList
        
    }
    
    func composeButton(){
         compostModel()
         let margin = (SCREENW - 3 * width) / 4
        for (index,value) in dataList.enumerate() {
            
            let rowX:CGFloat = CGFloat(index / 3)
            let comY:CGFloat = CGFloat(index % 3)
            let x = margin * (comY + 1) + comY * width
            let y = margin * (rowX + 1) + rowX * height
            let but = CommposeButton()
            but.setTitle(value.title, forState: .Normal)
            but.setImage(UIImage(named: value.icon!), forState: .Normal)
            but.addTarget(self, action:#selector(CommposeView.btnClick(_:)), forControlEvents: .TouchUpInside)
            but.model = value
            but.frame = CGRectMake(x, y + SCREENH, width, height)
            addSubview(but)
            
            buttons.append(but)
        }
    }
    
    func btnClick(btn:CommposeButton){
            
                UIView.animateWithDuration(0.5, animations: {
                    
                    for value in self.buttons {
                        value.alpha = 0.2
                            if  btn == value {
                                  value.transform = CGAffineTransformMakeScale(2, 2)
                            } else {
                            
                                  value.transform = CGAffineTransformMakeScale(0.2, 0.2)
                            }
                     }
                    
                    }, completion: { (_) in
                        
                        UIView.animateWithDuration(0.25, animations: { 
                            for value in self.buttons {
                                
                                value.alpha = 1
                                value.transform = CGAffineTransformIdentity
                            }
                            }, completion: { (_) in
                                
                                guard let col = btn.model?.nextvc else { return }
                                
                                
                                guard let proter =  NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else {
                                
                                    return
                                }
                                print(proter)
                                
                                
                                guard  let cla = NSClassFromString("\(proter).\(col)") as? UIViewController.Type else {
                                    return
                                }
                                let vc = cla.init()
                                
                                let nav = UINavigationController(rootViewController: vc)
                                self.target?.presentViewController(nav, animated: true, completion: { 
                                    self.removeFromSuperview()
                                })
                        })
                })
               
            
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        anminAction(false)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.4 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.removeFromSuperview()
        }
      
    
    }
    func anminAction(isPull:Bool){
    //true上来,显示页面
        let height:CGFloat = isPull ? -350 : 350
        let butts = isPull ? buttons.enumerate() : buttons.reverse().enumerate()
        
        for (i,value) in butts {
            
            //设置动画
            let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            //设置tovalue
            anim.toValue = NSValue(CGPoint: CGPointMake(value.center.x, value.center.y + height))
            //开始时间
            anim.beginTime = CACurrentMediaTime() + Double(i) * 0.025
            
            //弹簧效果
            anim.springBounciness = 10
            
            //动画系数
            anim.springSpeed = 8
            //开始
            value.pop_addAnimation(anim, forKey: nil)
            
        }
    }
    private lazy var imageView:UIImageView = UIImageView(image: UIImage.commposeImage().applyLightEffect())
    private lazy var imageTitle:UIImageView = UIImageView(imageName: "compose_slogan")
    

}
