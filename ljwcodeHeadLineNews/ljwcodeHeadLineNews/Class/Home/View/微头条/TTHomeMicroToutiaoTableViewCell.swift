//
//  TTHomeMicroToutiaoTableViewCell.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2022/2/22.
//  Copyright © 2022 ljwcode. All rights reserved.
//

import Foundation
import UIKit

@objc(TTHomeNewsRightVideoTableViewCellDelegate)
protocol TTHomeMicroToutiaoTableViewCellDelegate : NSObjectProtocol{
    func TTMicroToutiaoShareHandle() -> Void
    func TTMicroToutiaoCommentHandle() -> Void
    func TTMicroToutiaoLikeHandle() -> Void
}

class TTHomeMicroToutiaoTableViewCell : UITableViewCell {
    private var newsModel : homeNewsSummaryModel?
    var imgCoverList : [detail_cover_list]?
    @objc weak var delegate : TTHomeMicroToutiaoTableViewCellDelegate?
    
    private lazy var userInfoView : UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var userAvatarImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 18
        imgView.layer.masksToBounds = true
        imgView.layer.borderColor = UIColor.gray.cgColor
        imgView.layer.borderWidth = 1.0
        return imgView
    }()
    
    private lazy var userNameLabel : SSThemedLabel = {
        let label = SSThemedLabel.init(frame: .zero, fontColor: .black, fontSize: 15, align: .left)
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var userInfoLabel : SSThemedLabel = {
        let label = SSThemedLabel.init(frame: .zero, fontColor: .gray, fontSize: 10, align: .left)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var focusBtn :  SSThemedButton = {
        let btn = SSThemedButton.init(frame: .zero, textColor: .black, backgroundColor: .white, textAlign: .center)
        btn .setTitle("关注", for: .normal)
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 1.0
        btn.layer.cornerRadius = 6.0
        return btn
    }()
    
    private lazy var newsTitleTextView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = UIColor.white
        textView.isSelectable = true
        textView.delegate = self
        textView.textAlignment = .center
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.isScrollEnabled  = false
        return textView
    }()
    
    private lazy var imgCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView .register(TTMicroToutiaoCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(TTMicroToutiaoCollectionViewCell.self))
        return collectionView
    }()
    
    private lazy var TTUGCActionItemView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var shareBtn : SSThemedButton = {
        let btn = SSThemedButton.init(frame: .zero, textColor: .black, backgroundColor: .white, textAlign: .center)
        btn.setImage(UIImage.init(named: "tab_share3"), for: .normal)
        btn.setTitle("分享", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
//        btn.titleEdgeInsets = UIEdgeInsets(top: 14, left: 5, bottom: -14, right: -5)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        btn.addTarget(self, action: #selector(TTMicroToutiaoShareHandle(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var commentBtn : SSThemedButton = {
        let btn = SSThemedButton.init(frame: .zero, textColor: .black, backgroundColor: .white, textAlign: .center)
        btn.setImage(UIImage.init(named: "comment_live_day"), for: .normal)
//        btn.titleEdgeInsets = UIEdgeInsets(top: 14, left: 5, bottom: -14, right: -5)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        btn.addTarget(self, action: #selector(TTMicroToutiaoCommentHandle(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var likeBtn : SSThemedButton = {
        let btn = SSThemedButton.init(frame: .zero, textColor: .black, backgroundColor: .white, textAlign: .center)
        btn.setImage(UIImage.init(named: "like"), for: .normal)
//        btn.titleEdgeInsets = UIEdgeInsets(top: 14, left: 5, bottom: -14, right: -5)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        btn.addTarget(self, action: #selector(TTMicroToutiaoLikeHandle(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var disLikeBtn : TTAlphaThemeButton = {
        let btn = TTAlphaThemeButton.init(frame: .zero)
        return btn
    }()
    
    private lazy var bottomLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.1
        return view
    }()
    
    @objc func TTMicroToutiaoShareHandle(sender:UIButton) {
        if delegate != nil && ((delegate?.responds(to: #selector(TTMicroToutiaoShareHandle))) != nil) {
            delegate?.TTMicroToutiaoShareHandle()
        }
    }
    
    @objc func TTMicroToutiaoCommentHandle(sender:UIButton){
        if delegate != nil && ((delegate?.responds(to: #selector(TTMicroToutiaoCommentHandle))) != nil) {
            delegate?.TTMicroToutiaoCommentHandle()
        }
    }
    
    @objc func TTMicroToutiaoLikeHandle(sender:UIButton) {
        if delegate != nil && ((delegate?.responds(to: #selector(TTMicroToutiaoLikeHandle))) != nil) {
            delegate?.TTMicroToutiaoLikeHandle()
        }
    }
    
    func createUI() {
        self.addSubview(self.userInfoView)
        self.userInfoView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(5)
            make.height.equalTo(50)
        }
        
        self.userInfoView.addSubview(self.userAvatarImgView)
        self.userAvatarImgView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.width.height.equalTo(36)
            make.centerY.equalTo(self.userInfoView)
        }
        
        self.userInfoView.addSubview(self.focusBtn)
        self.focusBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.userInfoView)
            make.right.equalTo(0)
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        
        self.userInfoView.addSubview(self.userNameLabel)
        self.userNameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.userAvatarImgView.snp.right).offset(5)
            make.top.equalTo(self.userAvatarImgView)
            make.height.equalTo(17)
            make.width.greaterThanOrEqualTo(kScreenWidth / 5)
            make.right.lessThanOrEqualTo(kScreenWidth * 4 / 5)
        }
        
        
        self.userInfoView.addSubview(self.userInfoLabel)
        self.userInfoLabel.snp.makeConstraints { make in
            make.left.equalTo(self.userNameLabel)
            make.top.equalTo(self.userNameLabel.snp.bottom).offset(5)
            make.height.equalTo(16)
            make.width.equalTo(kScreenWidth - 60 - 20 - 20)
            make.right.equalTo(self.focusBtn.snp.left).offset(-10)
        }
        
        self.addSubview(self.newsTitleTextView)
        self.newsTitleTextView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(self.userInfoView.snp.bottom).offset(5)
            make.height.greaterThanOrEqualTo(50)
            make.height.lessThanOrEqualTo(MAXFLOAT)
        }
        
        self.addSubview(self.imgCollectionView)
        self.imgCollectionView.snp.makeConstraints { make in
            make.left.equalTo(self.newsTitleTextView)
            make.right.equalTo(self.newsTitleTextView)
            make.top.equalTo(self.newsTitleTextView.snp.bottom).offset(5)
            make.height.equalTo(130)
        }
        
        self.addSubview(self.TTUGCActionItemView)
        self.TTUGCActionItemView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
            make.top.equalTo(self.imgCollectionView.snp.bottom).offset(5)
            make.bottom.equalTo(-10)
        }
        
        self.TTUGCActionItemView.addSubview(self.shareBtn)
        self.shareBtn.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(50)
            make.width.equalTo(90)
        }
        
        self.TTUGCActionItemView.addSubview(self.commentBtn)
        self.commentBtn.snp.makeConstraints { make in
            make.left.equalTo(self.shareBtn.snp.right).offset(0)
            make.top.equalTo(self.shareBtn)
            make.width.height.equalTo(self.shareBtn)
        }
        
        self.TTUGCActionItemView.addSubview(self.likeBtn)
        self.likeBtn.snp.makeConstraints { make in
            make.left.equalTo(self.commentBtn.snp.right).offset(0)
            make.top.equalTo(self.shareBtn)
            make.width.height.equalTo(self.shareBtn)
        }
        
        self.TTUGCActionItemView.addSubview(self.disLikeBtn)
        self.disLikeBtn.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.centerY.equalTo(self.TTUGCActionItemView)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        
        self.addSubview(self.bottomLineView)
        self.bottomLineView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-2)
            make.top.equalTo(self.TTUGCActionItemView.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
    }
    
    @objc var summaryModel : homeNewsSummaryModel! {
        didSet{
            guard let model = summaryModel else{
                return
            }
            
            self.newsModel = model
            self.imgCoverList = model.infoModel.detail_cover_list
            self.userAvatarImgView .sd_setImage(with: URL.init(string: model.infoModel.user.avatar_url))
            self.userNameLabel.text = model.infoModel.user.name
            
            let publishTime = TT_TimeIntervalConverString .tt_converTimeInterval(toString: model.infoModel.publish_time)
            userInfoLabel.text = String.init(format: "%@ · %@", publishTime,model.infoModel.user.remark_name)
            let text = model.infoModel.rich_content
            let normalText : String = String(text.prefix(50)).replacingOccurrences(of: "<br>", with: "\n")
            let highLightText = "...全文"
            let allText = normalText.appending(highLightText)
            if(model.infoModel.detail_cover_list.isEmpty){
                self.imgCollectionView.isHidden = true
                self.TTUGCActionItemView.snp.remakeConstraints { make in
                    make.left.equalTo(10)
                    make.top.equalTo(self.newsTitleTextView.snp.bottom).offset(5)
                    make.right.equalTo(-10)
                    make.height.equalTo(50)
                }
                
                if (model.infoModel.rich_content as NSString).length < 50 {
                    let attr : NSMutableAttributedString = NSMutableAttributedString.init(string: normalText)
                    attr.mc_addFont(UIFont.systemFont(ofSize: 18), on: NSRange(location: 0, length: (normalText as NSString).length))
                    attr.mc_addForegroundColor(UIColor.black, range: NSRange(location: 0, length: (normalText as NSString).length))
                    self.newsTitleTextView.attributedText = attr
                } else {
                    
                    let attr = NSMutableAttributedString.init(string: allText)
                    attr.mc_addFont(UIFont.systemFont(ofSize: 18), on: NSRange.init(location: 0, length: 50))
                    attr.mc_addForegroundColor(UIColor.black, range: NSRange.init(location: 0, length: 50))
                    attr.mc_addFont(UIFont.systemFont(ofSize: 18), on: NSRange.init(location: 50, length: 5))
                    attr.mc_addForegroundColor(UIColor.blue, range: NSRange.init(location: 50, length: 5))
                    
                    self.newsTitleTextView.attributedText = attr
                }
                
            }else {
                if (model.infoModel.rich_content as NSString).length < 50 {
                    let attr : NSMutableAttributedString = NSMutableAttributedString.init(string: normalText)
                    attr.mc_addFont(UIFont.systemFont(ofSize: 18), on: NSRange(location: 0, length: (normalText as NSString).length))
                    attr.mc_addForegroundColor(UIColor.black, range: NSRange(location: 0, length: (normalText as NSString).length))
                    self.newsTitleTextView.attributedText = attr
                } else {
                    
                    let attr = NSMutableAttributedString.init(string: allText)
                    attr.mc_addFont(UIFont.systemFont(ofSize: 18), on: NSRange.init(location: 0, length: 50))
                    attr.mc_addForegroundColor(UIColor.black, range: NSRange.init(location: 0, length: 50))
                    attr.mc_addFont(UIFont.systemFont(ofSize: 18), on: NSRange.init(location: 50, length: 5))
                    attr.mc_addForegroundColor(UIColor.blue, range: NSRange.init(location: 50, length: 5))
                    
                    self.newsTitleTextView.attributedText = attr
                }
            }
            self.commentBtn .setTitle(String.init(format: "%@", model.infoModel.comment_count), for: .normal)
            self.likeBtn.setTitle(String.init(format: "%@", model.infoModel.digg_count), for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension TTHomeMicroToutiaoTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgCoverList!.count > 0 ? (self.imgCoverList!.count > 1 ? 2 : 1) : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TTMicroToutiaoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TTMicroToutiaoCollectionViewCell.self), for: indexPath) as! TTMicroToutiaoCollectionViewCell
        cell.imgCoverModel = self.imgCoverList![indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (kScreenWidth - 25)/2, height: 130)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "readAll" {
            
            return false
        }
        return true
    }
}

