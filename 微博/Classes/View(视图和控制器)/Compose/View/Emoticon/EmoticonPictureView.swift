//
//  EmoticonPictureView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/29.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

private let EmoticonPictureViewID = "EmoticonPictureViewID"

class EmoticonPictureView: UICollectionView {
    
    let emoticon = EmoticonTools.sharedTools.Emoticonss
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setupUI()
    }
    
    func setupUI(){
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(SCREENW, 216 - 40)
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        dataSource = self
        registerClass(EmoticonPictureViewCell.self, forCellWithReuseIdentifier: EmoticonPictureViewID)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EmoticonPictureView:UICollectionViewDataSource{

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return emoticon.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emoticon[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonPictureViewID, forIndexPath: indexPath) as! EmoticonPictureViewCell
         cell.backgroundColor = self.backgroundColor
        cell.emoticon = emoticon[indexPath.section][indexPath.item]
//        cell.indexPath = indexPath
        return cell
    }
    
}
