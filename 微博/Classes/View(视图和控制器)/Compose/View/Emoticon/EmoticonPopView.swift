//
//  EmoticonPopView.swift
//  微博
//
//  Created by 牛晴晴 on 16/8/2.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class EmoticonPopView: UIView {

    @IBOutlet weak var emoticonButton: EmoticonPictureButton!
    
    
    //从xib里面记载视图
    class func popView() -> EmoticonPopView{
    
        return NSBundle.mainBundle().loadNibNamed("EmoticonPopView", owner: nil, options: nil).last! as! EmoticonPopView
    }
}
