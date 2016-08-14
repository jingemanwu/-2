//
//  Extension+NSAttributedString.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/31.
//  Copyright © 2016年 SH. All rights reserved.
//

import Foundation

extension NSAttributedString{

    //常见附件,图片是放在富文本中以附件的形式存在
    
    convenience init(emoticon:Emoticon,y:CGFloat,lineHeight:CGFloat?){
    let att = EmoticonTextAttachment()
    att.emoticon = emoticon
    att.image = UIImage.imageBoudle(emoticon.path)
    let lineHeight = lineHeight
    att.bounds = CGRectMake(0, y, lineHeight!, lineHeight!)
    self.init(attachment: att)
    
    }
}
