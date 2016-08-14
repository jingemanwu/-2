//
//  ComposePictureView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/27.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

private let PictureViewID = "PictureViewID"
class ComposePictureView: UICollectionView {
    
    var imageData:[UIImage] = [UIImage]()
     var colBlock:(() -> ())?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setupUI()
    }
    func imageCompose(image:UIImage){
        self.hidden = false
    
        imageData.append(image)
        reloadData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupUI(){
        self.hidden = true
        backgroundColor = UIColor.whiteColor()
        let layout:UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let cellMargin:CGFloat = 5
        let cellWH = (SCREENW - 20 - 2 * cellMargin) / 3
        layout.itemSize = CGSizeMake(cellWH , cellWH)
        layout.minimumLineSpacing = cellMargin
        layout.minimumInteritemSpacing = cellMargin
        self.dataSource = self
        self.delegate = self
      self.registerClass(composePictureCell.self, forCellWithReuseIdentifier: PictureViewID)
    }
}

extension ComposePictureView:UICollectionViewDataSource,UICollectionViewDelegate{

   
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.imageData.count == 0 || self.imageData.count == 9 {
            
            return self.imageData.count
            
        }
        
        return self.imageData.count + 1
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell = self.dequeueReusableCellWithReuseIdentifier(PictureViewID, forIndexPath: indexPath) as! composePictureCell
        cell.blockDelete = {
        
            self.imageData.removeAtIndex(indexPath.item)
            self.reloadData()
        }
        if indexPath.item == self.imageData.count {
            
            cell.image = nil
        } else
        {
            cell.image = imageData[indexPath.item]
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if  indexPath.item == self.imageData.count {
            deselectItemAtIndexPath(indexPath, animated: true)
            
            colBlock?()
        }
        
    }
    
}

class composePictureCell: UICollectionViewCell {
    
    var blockDelete :(() -> ())?
    
    var image :UIImage?{
    
        didSet{
        if image == nil
        {
            imageView.image = UIImage(named: "compose_pic_add")
            imageView.highlightedImage = UIImage(named: "compose_pic_add_highlighted")
            
            but.hidden = true
            
        } else{
            
            imageView.image = image
            imageView.highlightedImage = nil
            but.hidden = false
            
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    

    
    func setupUI(){
    
        contentView.addSubview(imageView)
        contentView.addSubview(but)
        
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView).offset(UIEdgeInsetsZero)
        }
        
        but.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(2)
            make.trailing.equalTo(contentView).offset(-2)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func btnClick(){
    
        blockDelete?()
        
    }
    private lazy var imageView:UIImageView = UIImageView()
    private lazy var but:UIButton = {
    
        let but = UIButton()
        but.setImage(UIImage(named:"compose_photo_close"), forState: .Normal)
        but.addTarget(self, action:#selector(composePictureCell.btnClick), forControlEvents: .TouchUpInside)
        but.sizeToFit()
        but.hidden = true
        return but
    }()
}

