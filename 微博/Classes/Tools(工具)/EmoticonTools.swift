//
//  EmoticonTools.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/29.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

 let palineMax = 20
let colm = 7
let row = 3

class EmoticonTools: NSObject {

    static let sharedTools:EmoticonTools  = EmoticonTools()
    private lazy var oneArray:[Emoticon] = [Emoticon]()
    //默认表情
     lazy var  defaultEmoticons:[Emoticon] = {
    
        return self.getArrayOne("default/")
    }()
    //emoji表情
    lazy var emojiEmoticons:[Emoticon] = {
    
        return self.getArrayOne("emoji/")
    }()
    //浪小花表情
    lazy var lxhEmoticons:[Emoticon] = {
    
        return self.getArrayOne("lxh/")
    }()
    
    //二位数组,多少页[一维数组20为一组总共有几组]
    //默认几组
    lazy var defaultEmoticonss:[[Emoticon]] = {
    
        return self.arrayTwo(self.defaultEmoticons)
    }()
    
    //emoji表情
    lazy var emojiEmoticonss:[[Emoticon]] = {
        
        return self.arrayTwo(self.emojiEmoticons)
    }()
    //默认几组
    lazy var lxhEmoticonss:[[Emoticon]] = {
        
        return self.arrayTwo(self.lxhEmoticons)
    }()
    
    //三维数组,有多组,三组,默认,emoji和浪小花
    lazy var Emoticonss:[[[Emoticon]]] = {
    
        var emoticons:[[[Emoticon]]] = [[[Emoticon]]]()
        emoticons.append(self.defaultEmoticonss)
        emoticons.append(self.emojiEmoticonss)
        emoticons.append(self.lxhEmoticonss)
        
        return emoticons
    }()
    let bundle:NSBundle = {
    
        var pa = NSBundle()
        let paths = NSBundle.mainBundle().pathForResource("Emoticons.bundle", ofType: nil)!
        pa = NSBundle(path: paths)!
        return pa
    }()
    
    // MARK: - 一维数组
    func getArrayOne(pathName:String) -> [Emoticon]{

        let path = bundle.pathForResource("\(pathName)info.plist", ofType: nil)!
        let array = NSArray(contentsOfFile: path)!
        
        var tempArray:[Emoticon] = [Emoticon]()
        
        for value in array {
            
            let model = Emoticon(dict: value as! [String : AnyObject])
            model.path =  "\(pathName)\(model.png ?? "")"
            tempArray.append(model)
            
        }
        
        return tempArray
        
        
    }
    
    // MARK: -  二维数组
    func arrayTwo(array:[Emoticon]) -> [[Emoticon]] {
        
        //页数
        let palineNumber = (array.count + palineMax - 1) / palineMax
        
        var tempArray:[[Emoticon]] = [[Emoticon]]()
        for index in 0..<palineNumber {
            let location = index * palineMax
            var length = palineMax
            if location + length > array.count {
                
                length = array.count - location
                
            }
           let range =  NSRange(location: location, length: length)
           let arrays =  (array as NSArray).subarrayWithRange(range) as! [Emoticon]
           tempArray.append(arrays)
        }
        
        return tempArray
       
    }
    
    func searchEmoticons(chs:String?) -> Emoticon?{
    
        for moticons in defaultEmoticons {
            if moticons.chs == chs {
                return moticons
            }
        }
        
        for moticons in lxhEmoticons {
            if moticons.chs == chs  {
                return moticons
            }
        }
        return nil
    }
}
