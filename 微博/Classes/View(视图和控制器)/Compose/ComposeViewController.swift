
//
//  ComposeViewController.swift
//  微博
//
//  Created by 牛晴晴 on 16/7/26.
//  Copyright © 2016年 SH. All rights reserved.
//

import UIKit
import SVProgressHUD

@available(iOS 9.0, *)
class ComposeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(237, green: 237, blue: 237)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ComposeViewController.btnClick))
       
          navigationItem.rightBarButtonItem =  UIBarButtonItem(titles: "发布", images: nil, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ComposeViewController.actionClick))
         navigationItem.rightBarButtonItem?.enabled = false
        navigationItem.titleView = titleLabel
        
        //键盘弹出通知
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.changeFrame(_:)), name:UIKeyboardWillChangeFrameNotification, object: nil)
        setupUI()

    }
    
  private  func setupUI(){
    
        view.addSubview(textView)
        textView.addSubview(pictureView)
        view.addSubview(toolBarView)
        textView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).offset(UIEdgeInsetsZero)
        }
        pictureView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(SCREENW - 20, SCREENW - 20))
            make.top.equalTo(textView).offset(100)
            make.centerX.equalTo(textView)
        }
        toolBarView.snp_makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.equalTo(44)
        }
    
        pictureView.colBlock = { [weak self] in
        
            self?.imageCompose()
            
        }
    
    // MARK: - 接收表情按钮发来的通知
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.emoticonClick(_:)), name: EmoticonPictureClick, object: nil)
     //删除表情按钮
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.deleteClick), name: EmoticonDeleteClick, object: nil)
    }
    
   
    //删除表情按钮回调
    func deleteClick(){
    
        textView.deleteBackward()
    }
    
    // MARK: - 表情按钮通知调用
    func emoticonClick(objc:NSNotification){
        
        guard let oc = objc.object as? Emoticon else { return }
        
        if oc.isEmoji {
            
            textView.insertText((oc.code ?? "" as NSString).emoji())
            print((oc.code ?? "" as NSString).emoji())
        } else {
           
            //把textView的内容放到可变富文本中
            let muatAtt = NSMutableAttributedString(attributedString:  textView.attributedText)
            
            //常见附件,图片是放在富文本中以附件的形式存在
//            let att = EmoticonTextAttachment()
//            att.emoticon = oc
//            att.image = UIImage.imageBoudle(oc.path)
            let lineHeight = textView.font?.lineHeight
//            att.bounds = CGRectMake(0, -4, lineHeight!, lineHeight!)
            
            let attr = NSAttributedString(emoticon: oc, y: -4, lineHeight: lineHeight)
            let selectedRange = textView.selectedRange
            muatAtt.replaceCharactersInRange(selectedRange, withAttributedString: attr)
            
            muatAtt.addAttributes([NSFontAttributeName : textView.font!], range: NSRange(location: 0, length:muatAtt.length))
            
            textView.attributedText = muatAtt
            textView.selectedRange = NSRange(location: selectedRange.location+1, length: 0)
        NSNotificationCenter.defaultCenter().postNotificationName("UITextViewTextDidChangeNotification", object: nil)
            textView.delegate?.textViewDidChange!(textView)
            
        }
 
        
    }
    
    // MARK: - 发布按钮
    func actionClick(){
    
        print("发布成功")
        var atr = ""
        NSAttributedString(attributedString: textView.attributedText).enumerateAttributesInRange(NSRange(location: 0, length: textView.attributedText.length), options: []) { (result, range, _) in
            
            if  let att = result["NSAttachment"] as? EmoticonTextAttachment {
                
                    atr += att.emoticon?.chs ?? ""
                
            } else {
            
                atr += (self.textView.attributedText.string as NSString).substringWithRange(range)
            }
        }
        
        pictureView.imageData.count > 0 ?sendTextlode(atr, images: pictureView.imageData):sendTextData(atr)
    }
  
    // MARK: - 取消
    func btnClick(){
    
        textView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - 标题控件
private lazy var titleLabel:UILabel = {
    
        let la = UILabel()
    let name = UserAccountViewModel.sharedModel.userInfo?.screen_name
    la.textAlignment = .Center
    la.numberOfLines = 0
    let str = "发微博\n\(name ?? "")"
    let attr:NSMutableAttributedString = NSMutableAttributedString(string: str)
    let range = (str as NSString).rangeOfString("\(name ?? "")")
    attr.addAttributes([NSFontAttributeName : UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:ThemeColor], range: range)
     la.attributedText = attr
     la.sizeToFit()
    
        return la
        
    }()
    // MARK: - textView
  private  lazy var textView:ComposeTextView = {
    
        let textView = ComposeTextView()
        textView.delegate = self
        textView.font = UIFont.systemFontOfSize(15)
        textView.textPlace = "我是否开始加福禄寿就发上来就分了就尽量快放假了深刻积分楼上的客服经理附件是离开房间了"
        textView.alwaysBounceVertical = true
    
             return textView
    
    }()
    
    // MARK: - 懒加载九宫格
    private lazy var pictureView:ComposePictureView = ComposePictureView()
    
    // MARK: - toolBar键盘
    private lazy var toolBarView:ComposeToolbarView = {
        let com = ComposeToolbarView()
        com.compost = { (type:ComposeToolbarViewType) in
            
            switch type {
                
            case .Picture: self.imageCompose()
            case .Mention:print("Mention")
            case .Trend: print("Trend")
            case .Emoticon: self.keyboardView()
            case .Add: print("Add")
                
            }
            
        }
        return com
    }()
    
        // MARK: - 表情键盘
   func  keyboardView(){
    
        if textView.inputView != nil {
            textView.inputView = nil
            toolBarView.isEmoticon = false
            
        } else {
        
            textView.inputView = keyboarkView
            toolBarView.isEmoticon = true
        }
        
         textView.becomeFirstResponder()
         textView.reloadInputViews()

    }
    
    // MARK: - 表情替换键盘通知调用
    func changeFrame(notification:NSNotification){
        
        guard let notifi = notification.userInfo else { return }
        
        let rect:NSValue = notifi["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let frame = rect.CGRectValue()
        let time = notifi["UIKeyboardAnimationDurationUserInfoKey"] as! NSNumber
        self.toolBarView.snp_updateConstraints { (make) in
            make.bottom.equalTo(frame.origin.y - SCREENH)
        }
        UIView.animateWithDuration(Double(time), animations: {
            self.toolBarView.layoutIfNeeded()
            
        })
    }

    // MARK: - 上传图片
    func imageCompose(){
    
        let pick:UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        self.presentViewController(pick, animated: true, completion: nil)
        
        
    }
    
    private lazy var keyboarkView:EmoticonKeyboardView = EmoticonKeyboardView()
    
    deinit{
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

@available(iOS 9.0, *)
extension ComposeViewController{

    // MARK: - 发布微博
    func sendTextData(text:String){
        
        NetworkTools.sharedManage.sendTextData(text, success: { (Data) in
            SVProgressHUD.showSuccessWithStatus("上传成功")
            
        }) { (error) in
            SVProgressHUD.showSuccessWithStatus("上传失败")
        }
        
    }
    
    func sendTextlode(states:String,images:[UIImage]){
    
        NetworkTools.sharedManage.sendTextImageLoad(states, images: images, success: { (Data) in
               SVProgressHUD.showSuccessWithStatus("上传成功")
            }) { (error) in
                
                SVProgressHUD.showSuccessWithStatus("上传失败")
                
        }
    }
    
}

@available(iOS 9.0, *)
extension ComposeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.pictureView.imageCompose(image.imageZIP(600))
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

@available(iOS 9.0, *)
extension ComposeViewController:UITextViewDelegate{

    func textViewDidChange(textView: UITextView) {
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
