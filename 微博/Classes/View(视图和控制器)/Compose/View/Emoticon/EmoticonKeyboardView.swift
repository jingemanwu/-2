//
//  EmoticonKeyboardView.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/29.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class EmoticonKeyboardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, SCREENW, 216))
        setupUI()
    }
    
    // MARK: - 添加页面
    func setupUI(){
        addSubview(toolbar)
        addSubview(pictureView)
        addSubview(pageControl)
        
        toolbar.snp_makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(40)
        }
        pictureView.snp_makeConstraints { (make) in
            make.leading.trailing.top.equalTo(self)
            make.bottom.equalTo(toolbar.snp_top)
        }
        pageControl.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
//            make.height.equalTo(20)
            make.bottom.equalTo(pictureView.snp_bottom)
            
        }
        // MARK: - toolbr点击事件回调
        toolbar.closure = {[weak self] (type:EmoticonTool) -> () in
            
            switch type {
            case .defalut:
                print("默认值")
            case .emoticob:
                print("表情")
            case .lxh:
                print("浪小花")
            }
            let index = NSIndexPath(forItem: 0, inSection: type.rawValue)
            self?.pictureView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
            
            self?.pageCurrent(index)
            
        }

        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @available(iOS 9.0, *)
    private lazy var toolbar:EmoticonToolbar =  EmoticonToolbar(frame: CGRectZero)
    
    private lazy var pictureView:EmoticonPictureView = {
    
        let picture = EmoticonPictureView()
        picture.backgroundColor =  self.backgroundColor
        picture.showsHorizontalScrollIndicator = false
        picture.showsVerticalScrollIndicator = false
        picture.pagingEnabled = true
        picture.bounces = false
        picture.delegate = self
        
        return picture
    }()
    
    private lazy var pageControl:UIPageControl = {
        
        let page = UIPageControl()
        page.numberOfPages = EmoticonTools.sharedTools.Emoticonss[0].count
        page.currentPage = 0
       
        page.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKey: "_currentPageImage")
        page.setValue(UIImage(named:"compose_keyboard_dot_normal"), forKey: "_pageImage")
        
        return page
    }()
    // MARK: - 设置pageControl的值
    func pageCurrent(indexPath:NSIndexPath){
        
       pageControl.numberOfPages = EmoticonTools.sharedTools.Emoticonss[indexPath.section].count
        
        pageControl.currentPage = indexPath.item
        
    }
}

@available(iOS 9.0, *)
extension EmoticonKeyboardView:UICollectionViewDelegate{

    func scrollViewDidScroll(scrollView: UIScrollView) {
        //屏幕的中心点,依照那个cell包含屏幕中心点,来决定那个cell过半,来切换底部的button,y可以随便
        var indexPath:NSIndexPath
        let point = CGPointMake(scrollView.contentOffset.x + SCREENW * 0.5, 100)
        
        let cell = self.pictureView.visibleCells().sort { (cell1, cell2) -> Bool in
            return cell1.frame.origin.x < cell2.frame.origin.x
        }
        if cell.count == 2 {
            let first = cell.first!
            let last = cell.last!
            (first.frame.contains(point)) ? (indexPath = pictureView.indexPathForCell(first)!) :  (indexPath = pictureView.indexPathForCell(last)!)
            
            toolbar.scrollViewBut(indexPath.section)
            self.pageCurrent(indexPath)

        }
    
    }
}

