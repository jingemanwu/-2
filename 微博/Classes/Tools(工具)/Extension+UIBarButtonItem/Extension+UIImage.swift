//
//  Extension+UIImage.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/28.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
extension UIImage{

    //保存截屏图片
   static func setupUI(){
        let image = commposeImage()
        let data = UIImagePNGRepresentation(image)
        data?.writeToFile("/Users/ushiharebare/Desktop/image.png", atomically: true)
    }
     // MARK: - 截屏
  static  func commposeImage() -> UIImage{
        
        let window = UIApplication.sharedApplication().keyWindow!
        UIGraphicsBeginImageContext(window.bounds.size)
        
        
        window.drawViewHierarchyInRect(window.bounds, afterScreenUpdates: false)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
        
    }
    
    // MARK: - 图片压缩
    func imageZIP(width:CGFloat) -> UIImage{
        
        if width < self.size.width {
            return self
        }
    
        let height = (width * self.size.height) / self.size.height
        let rect = CGRectMake(0, 0, width, height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        self.drawInRect(rect)
        let retuls =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return retuls
        
    }
    
    // MARK: - 图片相对路径
   static func imageBoudle(namedPath:String?) -> UIImage?{
        
   return  UIImage(named: namedPath ?? "", inBundle: EmoticonTools.sharedTools.bundle, compatibleWithTraitCollection: nil)
    
    }
}
