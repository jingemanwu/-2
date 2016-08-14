//
//  HomeViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/19.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit

private let identifer = "cell"
class HomeViewController: VisitorViewController {
    
   lazy var userStatuse:UserStatuseModel = UserStatuseModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
            if !loinType  {
                
                visitorView?.setViewText(nil, imageName: nil)
                
                return
            }
         loadData()
        navigationController?.view.insertSubview(textLabel, belowSubview: (navigationController?.navigationBar)!)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(StautsCell.self, forCellReuseIdentifier: identifer)
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .None
        
        indicatorView.color = ThemeColor
        

        tableView.tableFooterView = indicatorView
        
        
        tableView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(HomeViewController.refreshChanage), forControlEvents: .ValueChanged)
    }
    func refreshChanage() {
        
        loadData()
    }
    
      lazy var indicatorView:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  lazy var refresh:Refresh = Refresh()
   
    // MARK: - 下拉显示数据
    private lazy var textLabel:UILabel = {
        
        let lab = UILabel()
        lab.frame = CGRectMake(0, 64 - 30, SCREENW, 30)
        lab.backgroundColor = ThemeColor
        lab.textAlignment = .Center
        lab.font = UIFont.systemFontOfSize(15)
        lab.textColor = UIColor.whiteColor()
        lab.hidden  = true
        
        return lab
    }()
}

extension HomeViewController{
    // MARK: - 刷新数据
    func loadData(){
        userStatuse.userStatuse(indicatorView.isAnimating()) {(issucces,count) in
            if issucces{
                
                self.indicatorView.stopAnimating()
                self.refresh.endRefreshing()
                print("数据请求成功")
                
                self.tableView.reloadData()
                if count >= 0 {
                    
                    self.animationgContext(count)
                    
                }
                
            } else {
                
                print("数据请求错误")
                return
            }
            
        }
    }

    func animationgContext(count:Int){
        if textLabel.hidden == false{
            
            return
        }
        self.textLabel.hidden = false
        
        var name = ""
        if count == 0 {
            name = "没有新数据"
        } else {
        
            name = "刷新了\(count)条数据"
        }
        
        self.textLabel.text = name
      
        UIView.animateWithDuration(0.25, animations: { 
            
            self.textLabel.transform = CGAffineTransformMakeTranslation(0, 30)
            
            }) { (_) in
                
                UIView.animateKeyframesWithDuration(0.25, delay: 1, options: [], animations: {
                    
                    self.textLabel.transform = CGAffineTransformIdentity
                    
                    }, completion: { (_) in
                        
                        self.textLabel.hidden = true
                })
        }
    }
}
extension HomeViewController:UITableViewDataSource,UITableViewDelegate{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  userStatuse.listData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:StautsCell = tableView.dequeueReusableCellWithIdentifier(identifer, forIndexPath: indexPath) as! StautsCell

        cell.cellModel = userStatuse.listData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)")
        if indexPath.row == userStatuse.listData.count - 1 && !indicatorView.isAnimating() {
            indicatorView.startAnimating()
            loadData()
            
        }

    }
    
    
  
}
