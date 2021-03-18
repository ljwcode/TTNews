//
//  TTPlayerEndMaskView.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/3/17.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit
import SnapKit

@objc(TTPlayerEndMaskDelegate)
protocol TTPlayerEndMaskDelegate : NSObjectProtocol{
    func TT_BackPopHandle() ->Void
    func TT_MoreHandle() ->Void
    func TT_SearchHandle() -> Void
    func TT_ReplayerVideoHandle() -> Void
}
@objc(TTPlayerEndMaskView)
class TTPlayerEndMaskView : UIView{
   @objc weak var delegate : TTPlayerEndMaskDelegate?
    let KScreenSize : CGSize = UIScreen .main.bounds.size
    private lazy var tipLabel : UILabel = {
        let label = UILabel()
        label.text = "分享到"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var leftLineView : UIView = {
       let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        return lineView
    }()
    
    private lazy var rightLineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        return lineView
    }()
    
    private lazy var rePlayBtn : UIButton = {
        let btn = UIButton()
        btn .setImage(UIImage(named: "replay"), for: UIControl.State.normal)
        btn .setTitle("重播", for: UIControl.State.normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(TT_ReplayHandle), for: .touchUpInside)
        return btn
    }()
    
    private lazy var sharePYQBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: ImageArray[0]), for: UIControl.State.normal)
        btn.setTitle(titleArray[0], for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        let imageWidth  = btn.imageView?.intrinsicContentSize.width
        let imageHeight = btn.imageView?.intrinsicContentSize.height
        let titleWidth = btn.titleLabel?.intrinsicContentSize.width
        let titleHeight = btn.titleLabel?.intrinsicContentSize.height
        
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.imageEdgeInsets = UIEdgeInsets(top: -titleHeight! - 10/2, left: 0, bottom: 0, right: -titleWidth!)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom:-imageHeight! - 10/2, right: 0)
        btn .addTarget(self, action: #selector(TT_sharePYQHandle), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shareWechatBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: ImageArray[1]), for: UIControl.State.normal)
        btn.setTitle(titleArray[1], for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        let imageWidth  = btn.imageView?.intrinsicContentSize.width
        let imageHeight = btn.imageView?.intrinsicContentSize.height
        let titleWidth = btn.titleLabel?.intrinsicContentSize.width
        let titleHeight = btn.titleLabel?.intrinsicContentSize.height
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.imageEdgeInsets = UIEdgeInsets(top: -titleHeight!, left: 0, bottom: 0, right: -titleWidth!)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!, right: 0)
        btn.addTarget(self, action: #selector(TT_shareWechatHandle), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shareQQBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: ImageArray[2]), for: UIControl.State.normal)
        btn.setTitle(titleArray[2], for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        let imageWidth  = btn.imageView?.intrinsicContentSize.width
        let imageHeight = btn.imageView?.intrinsicContentSize.height
        let titleWidth = btn.titleLabel?.intrinsicContentSize.width
        let titleHeight = btn.titleLabel?.intrinsicContentSize.height
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.imageEdgeInsets = UIEdgeInsets(top: -titleHeight!, left: 0, bottom: 0, right: -titleWidth!)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!, right: 0)
        btn.addTarget(self, action: #selector(TT_shareQQHandle), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shareQQKJBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: ImageArray[1]), for: UIControl.State.normal)
        btn.setTitle(titleArray[1], for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        let imageWidth  = btn.imageView?.intrinsicContentSize.width
        let imageHeight = btn.imageView?.intrinsicContentSize.height
        let titleWidth = btn.titleLabel?.intrinsicContentSize.width
        let titleHeight = btn.titleLabel?.intrinsicContentSize.height
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.imageEdgeInsets = UIEdgeInsets(top: -titleHeight!, left: 0, bottom: 0, right: -titleWidth!)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!, right: 0)
        btn.addTarget(self, action: #selector(TT_shareQQKJHandle), for: .touchUpInside)
        return btn
    }()
   
    private lazy var TTPlayerBackBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "lefterbackicon_titlebar_dark"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(TT_PopHandle), for:.touchUpInside)
        
        return btn
    }()
    
    private lazy var TTMoreBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "new_morewhite_titlebar"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(TT_MoreHandle), for: .touchUpInside)
        return btn
    }()
    
    private lazy var TTSearchBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tsv_overlaytop_search"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(TT_SearchHandle), for: .touchUpInside)
        return btn
    }()
        
    @objc func TT_ReplayHandle(replayBtn : UIButton){
        if delegate?.TT_ReplayerVideoHandle() != nil{
            delegate?.TT_ReplayerVideoHandle()
        }
    }
    
    @objc func TT_sharePYQHandle(PYQBtn : UIButton){
        
    }
    
    @objc func TT_shareWechatHandle(WechatBtn : UIButton){
        
    }
    
    @objc func TT_shareQQHandle(QQBtn : UIButton){
        
    }
    
    @objc func TT_shareQQKJHandle(QQKJBtn : UIButton){
        
    }
    
    @objc func TT_PopHandle(TT_PopBackBtn : UIButton){
        if delegate?.TT_BackPopHandle() != nil{
            delegate?.TT_BackPopHandle()
        }
    }
    
    @objc func TT_MoreHandle(TT_MoreBtn : UIButton){
        if delegate?.TT_MoreHandle() != nil{
            delegate?.TT_MoreHandle()
        }
    }
    
    @objc func TT_SearchHandle(TT_SearchBtn : UIButton){
        if delegate?.TT_SearchHandle() != nil{
            delegate?.TT_SearchHandle()
        }
    }
    
    var ImageArray : [String] = ["pyq_newShare","weixin_newShare","qq_newShare","qqkj_newShare"]
    var titleArray : [String] = ["朋友圈","微信","QQ","QQ空间"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        self.backgroundColor = UIColor.black
        self.alpha = 0.8
        
    }
    public func createUI(){
        
        addSubview(TTPlayerBackBtn)
        TTPlayerBackBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(0)
            make.width.height.equalTo(20)
        }
        
        addSubview(TTMoreBtn)
        TTMoreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(TTPlayerBackBtn)
            make.width.height.equalTo(TTPlayerBackBtn)
        }
        
        addSubview(TTSearchBtn)
        TTSearchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(TTMoreBtn)
            make.right.equalTo(TTMoreBtn.snp_leftMargin).offset(-20)
            make.width.height.equalTo(TTMoreBtn)
        }
        
        addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(frame.height * 0.25)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        addSubview(leftLineView)
        leftLineView.snp.makeConstraints { (make) in
            make.right.equalTo(tipLabel.snp_leftMargin).offset(-5)
            make.top.equalTo(tipLabel.snp_centerY)
            make.width.equalTo(60)
            make.height.equalTo(1)
        }
        
        addSubview(rightLineView)
        rightLineView.snp.makeConstraints { (make) in
            make.left.equalTo(tipLabel.snp_rightMargin).offset(5)
            make.top.equalTo(leftLineView)
            make.width.height.equalTo(leftLineView)
        }
        
        var space : CGFloat = CGFloat()
        space = (KScreenSize.width - 60 * 4 - KScreenSize.width * 0.3)/3
        
        addSubview(sharePYQBtn)
        sharePYQBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(frame.width * 0.2)
            make.height.equalTo(80)
            make.width.equalTo(60)
        }
        
        addSubview(shareWechatBtn)
        shareWechatBtn.snp.makeConstraints { (make) in
            make.left.equalTo(sharePYQBtn.snp_rightMargin).offset(space)
            make.top.equalTo(sharePYQBtn)
            make.height.width.equalTo(sharePYQBtn)
        }
        
        addSubview(shareQQBtn)
        shareQQBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shareWechatBtn.snp_rightMargin).offset(space)
            make.height.width.equalTo(shareWechatBtn)
            make.top.equalTo(shareWechatBtn)
        }
        
        addSubview(shareQQKJBtn)
        shareQQKJBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shareQQBtn.snp_rightMargin).offset(space)
            make.top.equalTo(shareQQBtn)
            make.height.width.equalTo(shareQQBtn)
        }
        
        addSubview(rePlayBtn)
        rePlayBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
    }
    
    override func layoutSubviews() {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
