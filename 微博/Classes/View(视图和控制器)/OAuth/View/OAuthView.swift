//
//  OAuthView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/20.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class OAuthView: UIProgressView {
    var timer:NSTimer?
    var isAniim:Bool = true
    // MARK: - 重写父类方法
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 64, SCREENW, 2))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 开始加载进度条动画
    func  start(){
        self.hidden = false
        self.progress = 0
        timer = NSTimer.scheduledTimerWithTimeInterval(1/120, target: self, selector: #selector(OAuthView.valueChanage), userInfo: nil, repeats: true)
        
    }
    
    // MARK: - 根据定时器加载进度条
    func valueChanage(){
        if isAniim {
            self.progress += 0.05
            if self.progress >= 0.95 {
                
                self.progress = 0.95
            }
        }
        else {
            
            if self.progress == 1 {
                
                self.hidden = true
                timer?.invalidate()
            }
            else{
                
                self.progress += 0.05
            }
        }
        
        
    }

    // MARK: - 关闭动画
    func endAnim(){
        
        isAniim = false
        
    }
    
    // MARK: - 移动进度条
    func removView(){
    
        removeFromSuperview()
    }
   func  setupUI(){
    
        self.tintColor = UIColor.blueColor()
    
    }
    
    // MARK: - 关闭定时器
    deinit{
    
        timer?.invalidate()
    }
    
}
