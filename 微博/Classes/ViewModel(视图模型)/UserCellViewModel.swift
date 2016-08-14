//
//  UserCellViewModel.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/23.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SDWebImage

class UserCellViewModel: NSObject {

    var statuse:UserStatuse?
    var myName:String?
    // MARK: - 会员等级
    var memberImage:UIImage?
    
    // MARK: - 微博认证用户图片
    var avaterImage:UIImage?
    
    // 转发微博的配图视图大小
    var retweetPictureViewSize: CGSize = CGSizeZero
    var originalPictureViewSize: CGSize = CGSizeZero
    
    // 微博来源处理富文本
    var sourceAttr: NSMutableAttributedString?
    
    // 转发数
    var repostsCountStr: String?
    // 评论数
    var commentsCountStr: String?
    // 表态数
    var attitudesCountStr: String?
    
    //原创微博转表情
    var originalEmoji:NSAttributedString?
    //转发转表情
    var retweetEmoji:NSAttributedString?
    
    init(statuse:UserStatuse) {
        super.init()
        
        self.statuse = statuse
        self.myName = statuse.user?.name
        
        self.memberImage = getMember(statuse.user?.mbrank)
        self.avaterImage = getAvaterImage(statuse.user?.verified)
        
        // 计算配图视图的大小
        self.retweetPictureViewSize = calcPictureSize(statuse.retweeted_status?.pic_urls)
        self.originalPictureViewSize = calcPictureSize(statuse.pic_urls)

        self.sourceAttr = sourceAtrr(statuse.source)
        self.repostsCountStr = CountStr(statuse.reposts_count, title: "转发")
        self.commentsCountStr = CountStr(statuse.comments_count, title: "评论")
        self.attitudesCountStr = CountStr(statuse.attitudes_count, title: "赞")
        self.originalEmoji = dealContentText(statuse.text)
        self.retweetEmoji = dealContentText(statuse.retweeted_status?.text)
    }
}

extension UserCellViewModel{
// MARK: - 转发,评论,赞条数
    func CountStr(count:Int,title:String) -> String{
        if count <= 0 {
            return title
        } else if count < 10000{
        
            return "\(count)条"
        } else {
        
            
            var intCount = count % 10000
            if intCount == 0{
            
                 return "\(intCount / 10000)万"
            } else {
            
                intCount = (count / 1000) / 10
                return "\(intCount)万"
            }
        }
        
        
    }
    
}

extension  UserCellViewModel{
// MARK: - 转发处理
    // "source": <a href="http://app.weibo.com/t/feed/1tqBja" rel="nofollow">360安全浏览器</a>
    func sourceAtrr(sourceStr:String?) -> NSMutableAttributedString{
        
        guard let source = sourceStr where source.containsString("\">") else {
        
            return attributedString("上海微博")
        }
        let startString = source.rangeOfString("\">")?.endIndex
        let endString = source.rangeOfString("</")?.startIndex
        
        let result = source.substringWithRange(startString!..<endString!)
        
       return  attributedString(result)
    }
    
    func attributedString(sourceStr:String) -> NSMutableAttributedString{
    
        let name = "转自 \(sourceStr)"
        let attributed = NSMutableAttributedString(string: name)
        let attrName = (name as NSString).rangeOfString("转自")
    
        attributed.addAttributes([NSForegroundColorAttributeName : UIColor.grayColor()], range: attrName)
        
        return attributed
        
        
    }

}
extension UserCellViewModel{
    func  updateSingleImagePictureViewSize(){
    
        retweetPictureViewSize = calcSingleImageSize(statuse?.retweeted_status?.pic_urls)
        originalPictureViewSize = calcSingleImageSize(statuse?.pic_urls)
    }
    
    //获取单张图片的大小
    private func calcSingleImageSize(pic_urls: [FigureView]?) -> CGSize{
    
        //取出图片地址
        guard let imageUrlString = pic_urls?.first?.thumbnail_pic!  else {
        
            return CGSizeZero
        }
        
        //1.根据图片的地址,取到已下载好的图片(从缓存里面取)
        
        if let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(imageUrlString){
            // SDWebImage会根据当前屏幕的缩放比去对图片进行缩放。
            // 如果想要正常显示的话就把其缩放回来
            let scale = UIScreen.mainScreen().scale
            var size = CGSize(width: image.size.width, height: image.size.height * scale)
            
            //过窄处理
            if size.width < 50 {
            
                let height = 50 / size.width * size.height
                size.width = 50
                size.height = height > 100 ? 100:height
            }
            return size
        }
        return CGSizeZero
    }
    
    // MARK: - 计算配图视图的大小
    func  calcPictureSize(pic_urls:[FigureView]?) -> CGSize{
    
        //获取图片整数
        let count = pic_urls?.count ?? 0
        
        //如果是0张,返回
        if count <= 0{
        
            return CGSizeZero
        }
        
        //根据count计算大小
        //1.求出几行几列
        let col = count == 4 ? 2 : (count > 3 ? 3 : count)
        let row = ((count - 1) / 3) + 1
        
        //求出每一张图片的大小,并且设置间距大小
        //每一个条目的高度
        let margin:CGFloat = 5
        let itemWH = (SCREENW - 2 * StatusCellMargin - 2 * margin) / 3
        
        //3.通过每一张图片的大小和列数求出宽度,行数求出高度
        let width = CGFloat(col) * itemWH + CGFloat(col - 1) * margin
        let height = CGFloat(row) * itemWH + CGFloat(row - 1) * margin
        
        return CGSize(width: width, height: height)
    
        
        
    }
    


    func getMember(meak: Int?) -> UIImage?{
        
        guard let mbr = meak else { return nil}
        
        if mbr > 0 && mbr < 7  {
            return UIImage(named: "common_icon_membership_level\(mbr)")
        }
        return UIImage(named: "common_icon_membership")
       
    }
    
    func getAvaterImage(ava:Int?) -> UIImage?{
    
        guard let va = ava else { return nil}
        
        switch va {
        case 1:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return UIImage(named: "avatar_vgirl")
        }
    }
}

extension UserCellViewModel {

    func dealContentText(text:String?) -> NSAttributedString?{
        
        guard let t = text else { return nil }
        // 正则格式
        // 遍历字符串
        /*
         -01 匹配的个数
         -02 匹配的结果（指针）
         -03 匹配的范围（指针）
         -04 匹配是否停止
         */
        let regex = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"
        let attr = NSMutableAttributedString(string: t)
        var temp:[MatchResult] = [MatchResult]()
        let lineHeight = UIFont.systemFontOfSize(15).lineHeight
        (t as NSString).enumerateStringsMatchedByRegex(regex) { (count, string, rang, nil) in
            
            let match = MatchResult(string: string.memory, range:rang.memory)
            temp.append(match)
            
            
            
            
            //            guard let emo = emotiocn as! Emoticon else { return }
            //            print(emotiocn?.chs)
        }
        for match in temp.reverse() {
            
            let enumer = match.string as! String
            print(enumer)
            
            guard  let emoticon = EmoticonTools.sharedTools.searchEmoticons(enumer) else {   return nil}
            let att = NSAttributedString(emoticon: emoticon, y: -4, lineHeight: lineHeight)
            
            
            attr.replaceCharactersInRange(match.range, withAttributedString: att)
            
            
            
        }
        
        return attr
    }

}
