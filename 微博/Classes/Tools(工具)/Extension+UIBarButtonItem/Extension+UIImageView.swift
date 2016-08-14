//
//  Extension+UIImageView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/20.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

extension UIImageView {
 
  convenience  init(imageName:String) {

    self.init(image:UIImage(named: imageName))    
    
    }
    
    func sd_image(imageName:String?,placeName:String){
        
        self.sd_setImageWithURL(NSURL(string:imageName ?? ""), placeholderImage: UIImage(named: placeName))
        
    }
}
