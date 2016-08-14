//
//  Refresh.swift
//  下拉刷新
//
//  Created by 牛晴晴 on 16/7/26.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
enum SHRefreshControlState:Int {
    case Normal = 0//正常
    case Pulling = 1//下拉中
    case Refreshing = 2//刷新
}

let RefreshControlH:CGFloat = 50
class Refresh: UIControl {

   weak var scrollerView:UIScrollView?
    var coState:SHRefreshControlState = .Normal
        {

        didSet{
        
            switch coState {
            case .Normal:
                
                self.label.text = "正常"
                
             if oldValue == .Refreshing {
                
                UIView.animateWithDuration(0.25, animations: { 
                    
                    self.scrollerView?.contentInset.top -= RefreshControlH
                    
                    }, completion: { (_) in
                        self.indicatorView.stopAnimating()
                        self.pullIndex.hidden = false
                })
                
            }
            UIView.animateWithDuration(0.25, animations: {
                
                self.pullIndex.transform = CGAffineTransformIdentity
            })
  
            case .Pulling:
                self.label.text="下拉中"
                UIView.animateWithDuration(0.25, animations: {
                    
                 self.pullIndex.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                
            })
            case .Refreshing:
                
                self.label.text = "刷新中"
                self.indicatorView.startAnimating()
                self.pullIndex.hidden = true
                
                UIView.animateWithDuration(0.25, animations: {
                    
                     self.scrollerView?.contentInset.top += RefreshControlH
                    
                    }, completion: { (_) in
                        
                        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
                })
 

        }
    }
    }
        
    override init(frame: CGRect) {
       
        super.init(frame: CGRectMake(0, -50,  UIScreen.mainScreen().bounds.width, 50))
        setupUI()
    }
    
    func  setupUI(){
        backgroundColor = UIColor.redColor()
        addSubview(label)
        addSubview(indicatorView)
        indicatorView.color = ThemeColor

        addSubview(pullIndex)
        label.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: label, attribute:.CenterX, relatedBy: .Equal, toItem: self, attribute:.CenterX, multiplier: 1, constant: 0))
        
         addConstraint(NSLayoutConstraint(item: label, attribute:.CenterY, relatedBy: .Equal, toItem: self, attribute:.CenterY, multiplier: 1, constant: 0))
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: indicatorView, attribute:.CenterX, relatedBy: .Equal, toItem: self, attribute:.CenterX, multiplier: 1, constant: -35))
        
        addConstraint(NSLayoutConstraint(item: indicatorView, attribute:.CenterY, relatedBy: .Equal, toItem: self, attribute:.CenterY, multiplier: 1, constant: 0))
        
        pullIndex.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: pullIndex, attribute:.CenterX, relatedBy: .Equal, toItem: self, attribute:.CenterX, multiplier: 1, constant: -35))
        
        addConstraint(NSLayoutConstraint(item: pullIndex, attribute:.CenterY, relatedBy: .Equal, toItem: self, attribute:.CenterY, multiplier: 1, constant: 0))
        

        
    }
    
    // MARK: - 将要添加到父view上
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        guard let scroller = newSuperview as? UIScrollView else { return }
       self.scrollerView = scroller
        scroller.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
       
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        setupRefreshControllState(self.scrollerView?.contentOffset.y)
    }
    
    func setupRefreshControllState(y:CGFloat?){
        if self.scrollerView!.dragging {
            
            let contentIntSetTop = self.scrollerView?.contentInset.top ?? 0
            if y > -RefreshControlH - contentIntSetTop && coState == .Pulling  {
            
                coState = .Normal
                
            } else if y <= -RefreshControlH - contentIntSetTop && coState == .Normal{
                coState = .Pulling
            }
        
        }else {
        
            if coState == .Pulling {
                
                coState = .Refreshing
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func endRefreshing(){
    
        coState = .Normal
    }
  private  lazy var label:UILabel = {
    
        let lab = UILabel()
        lab.text = "正常"
        return lab
    }()
    private lazy var indicatorView:UIActivityIndicatorView = {
     let inde = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        return inde
    }()
    
    
    deinit{
    
        print("销毁了")
    }
    private lazy var  pullIndex :UIImageView = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
}
