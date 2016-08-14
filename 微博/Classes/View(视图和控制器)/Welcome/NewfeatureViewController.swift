//
//  NewfeatureViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/22.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

class NewfeatureViewController: UIViewController {
    let idenifer = "cell"
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    override func loadView() {
        
        view = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        setupUI()
    }
    
    func setupUI(){
        
        layout.itemSize = CGSizeMake(SCREENW, SCREENH)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.registerClass(NewCell.self, forCellWithReuseIdentifier: idenifer)
    }
    

    lazy var collectionView:UICollectionView = UICollectionView(frame: CGRectMake(0, 0, SCREENW, SCREENH), collectionViewLayout: self.layout)
    
}

extension NewfeatureViewController:UICollectionViewDataSource,UICollectionViewDelegate{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(idenifer, forIndexPath: indexPath) as! NewCell
        cell.backgroundColor = RandomColor()
        cell.index = Int(indexPath.item)
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
       let index = Int(scrollView.contentOffset.x / SCREENW)
        if index == 3 {
            let cell: NewCell = self.collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0)) as! NewCell
            
            cell.startAnime()
            
        }
        
    }
}

class NewCell:UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setcellupUI()
    }
    
    var index:Int = 0{
    
        didSet{
            let imageName:String = "new_feature_\(index + 1)"
            baImage.image = UIImage(named: imageName)
            
        }
    }
    func setcellupUI(){
    
        contentView.addSubview(baImage)
        contentView.addSubview(button)
        baImage.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView).offset(UIEdgeInsetsZero)
        }
        button.snp_makeConstraints { (make) in
            make.bottom.equalTo(contentView).offset(-100)
            make.centerX.equalTo(contentView)
        }
        
       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnime(){
    
        
        self.button.transform = CGAffineTransformMakeScale(0, 0)
        button.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.25, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            
            self.button.hidden = false
            self.button.transform = CGAffineTransformIdentity
            
            }) { (_) in
               self.button.userInteractionEnabled = true
        }
    }
    
    func btnClick(){
    
        NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootViewControllerNoti, object: "cell")
    }
    lazy var button:UIButton = {
    
        let but = UIButton()
        but.setBackgroundImage(UIImage(named:"new_feature_finish_button"), forState: .Normal)
        but.setBackgroundImage(UIImage(named:"new_feature_finish_button_highlighted"), forState: .Highlighted)
        but.setTitle("立即体验", forState: .Normal)
        but.sizeToFit()
        but.addTarget(self, action: #selector(NewCell.btnClick), forControlEvents: .TouchUpInside)
        but.hidden = true
        
        return but
    }()
    
    lazy var baImage:UIImageView = UIImageView()
}

