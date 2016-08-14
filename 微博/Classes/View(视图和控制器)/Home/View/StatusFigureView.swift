//
//  StatusFigureView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/25.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

//每一个条目之间的间距
let StatusPictureItemMargin:CGFloat = 5



//每个条目宽高(collectionView item 的宽高，尽量设置成整数)
let StatusPictureItemWH:CGFloat = {

    //转成Int
    
    let intW = Int((SCREENW - 2 * StatusPictureItemMargin - 2 * StatusCellMargin ) / 3)
    //转成float
    let floatW = CGFloat(intW)
    return floatW
}()

private let StatusFigureViewID = "StatusFigureViewID"
class StatusFigureView: UICollectionView {
    
    //元组类型
    var  dataInfo:(pic_urls:[FigureView],size:CGSize)?{
    
        didSet{
        
            if dataInfo?.pic_urls.count == 1 {
            let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
                layout.itemSize = dataInfo?.size ?? CGSizeZero
            } else {
            
                let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
                layout.itemSize = CGSize(width: StatusPictureItemWH, height: StatusPictureItemWH)
            }
            
            self.snp_updateConstraints { (make) in
                make.size.equalTo(dataInfo?.size ?? CGSizeZero)
            }
            reloadData()
        }
    }
    
    
//    var pic_urls:[FigureView]?{
//    
//        didSet{
//            print("\(pic_urls?.count)")
//            congLabel.text = "\(pic_urls?.count ?? 0)"
////            let size = getFigureSize(pic_urls)
//            self.snp_updateConstraints { (make) in
////                make.size.equalTo(size)
//            }
//            reloadData()
//        }
//    }
    

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func setupUI(){
    
    backgroundColor = UIColor.clearColor()
    let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
    flowLayout.itemSize = CGSize(width: StatusPictureItemWH, height: StatusPictureItemWH)
    flowLayout.minimumLineSpacing = StatusPictureItemMargin
    flowLayout.minimumInteritemSpacing = StatusPictureItemMargin
    self.collectionViewLayout = flowLayout 
    self.dataSource = self
    delegate = self
    self.registerClass(collection.self, forCellWithReuseIdentifier: StatusFigureViewID)
    
    self.snp_makeConstraints { (make) in
    
      make.center.equalTo(self)
    }
    addSubview(congLabel)
    congLabel.snp_makeConstraints { (make) in
        make.center.equalTo(self)
    }
    
    
    }
  
//    func getFigureSize(pic_urls:[FigureView]?) -> CGSize{
//        
//        guard let vi = pic_urls where vi.count > 0 else { return CGSizeMake(0.0, 0.0) }
//        
//        let com = pic_urls?.count == 4 ? 2 : pic_urls?.count >= 3 ? 3 : pic_urls?.count
//        let row = pic_urls?.count == 4 ? 2 : pic_urls?.count >= 3 ? (((pic_urls?.count)! - 1) / 3 + 1 ): 1
//        
//        let width = com! * itemWith + ( com! - 1 ) * magin
//        let heigth = row * itemWith + (row - 1) * magin
//        
//        return CGSizeMake(CGFloat(width), CGFloat(heigth))
//        
//        
//    }
    

    private var congLabel:UILabel = UILabel(text: nil, textColor:  UIColor.redColor(), textSize: 35)
    
}
extension StatusFigureView:UICollectionViewDataSource,UICollectionViewDelegate{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataInfo?.pic_urls.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StatusFigureViewID, forIndexPath: indexPath) as! collection
        cell.imageURl = dataInfo?.pic_urls[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let photoBrowser = SDPhotoBrowser()
        photoBrowser.delegate = self
        //当前选中的图片
        photoBrowser.currentImageIndex = indexPath.item
        //总图数
        photoBrowser.imageCount = dataInfo?.pic_urls.count ?? 0
        //父控件
        photoBrowser.sourceImagesContainerView = self
        photoBrowser.show()
    }
}

extension StatusFigureView:SDPhotoBrowserDelegate{

    func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        let cell = self.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0)) as! collection
        return cell.imageView.image
        
        
    }
}

class collection: UICollectionViewCell {
    var imageURl:FigureView? {
    
        didSet{
        
            imageView.sd_image(imageURl?.thumbnail_pic, placeName: "weibo_placeholder")
            
            if let img = imageURl?.thumbnail_pic where img.hasSuffix(".gif"){
            
                gigImageView.hidden = false
            }else {
            
                gigImageView.hidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setupUI(){
    
       
        contentView.addSubview(imageView)
         contentView.addSubview(gigImageView)
        
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView).offset(UIEdgeInsetsZero)
        }
        
        gigImageView.snp_makeConstraints { (make) in
            make.bottom.equalTo(contentView)
            make.trailing.equalTo(contentView)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var gigImageView:UIImageView = UIImageView(imageName: "timeline_image_gif")
    lazy var imageView:UIImageView = {
    
        let image = UIImageView(imageName: "weibo_placeholder")
        image.contentMode = .ScaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
}

