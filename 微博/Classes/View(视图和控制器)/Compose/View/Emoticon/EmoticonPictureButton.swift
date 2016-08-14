//
//  EmoticonPictureButton.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/31.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class EmoticonPictureButton: UIButton {

    var emoticon:Emoticon?{
    
        didSet{
        
            guard let emoti = emoticon else { return }
            if emoti.isEmoji == true {
            
                self.setTitle((emoticon?.code ?? "" as NSString).emoji(), forState: .Normal)
                self.setImage(nil, forState: .Normal)
                 self.setImage(nil, forState: .Highlighted)
                
            } else {
                
                self.setImage(UIImage.imageBoudle(emoticon!.path), forState: .Normal)
                self.setImage(UIImage.imageBoudle(emoticon!.path), forState: .Highlighted)
                
                self.setTitle(nil, forState: .Normal)
            }

        }
    }

}
