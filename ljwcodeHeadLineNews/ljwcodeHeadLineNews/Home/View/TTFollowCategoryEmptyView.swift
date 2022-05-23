//
//  TTFollowCategoryEmptyView.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/10.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

@objc(TT_FollowCategoryEmptyDelegate)
protocol TT_FollowCategoryEmptyDelegate : NSObjectProtocol{
    func TT_MoreFocusHandle() ->Void
}

@objc(TTFollowCategoryEmptyView)
class TTFollowCategoryEmptyView: UIView {
    
    @objc weak var delegate : TT_FollowCategoryEmptyDelegate?
        
    private lazy var centerImgView : UIImageView = {
        let ImgView = UIImageView()
        ImgView.image = UIImage.init(named: "IMG_0070")
        ImgView.layer.borderColor = UIColor.red.cgColor
        ImgView.layer.borderWidth = 1
        return ImgView
    }()
    
    private lazy var tipLabel : UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "关注之后,这里才会有内容哦"
        tipLabel.textColor = UIColor.gray
        tipLabel.font = UIFont.systemFont(ofSize: 10)
        tipLabel.textAlignment = NSTextAlignment.center
        tipLabel.adjustsFontSizeToFitWidth = true
        return tipLabel
    }()
    
    private lazy var focusBtn : UIButton = {
       let focusBtn = UIButton()
        focusBtn .setTitle("可能感兴趣的人", for: UIControl.State.normal)
        focusBtn.setTitleColor(UIColor.red, for: UIControl.State.normal)
        focusBtn.backgroundColor = UIColor.white
        focusBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        focusBtn.titleLabel?.textAlignment = NSTextAlignment.center
        focusBtn.layer.borderColor = UIColor.red.cgColor
        focusBtn.layer.borderWidth = 2
        focusBtn .addTarget(self, action: #selector(TT_moreFocusHandle), for:.touchUpInside )
        return focusBtn
    }()
    
    @objc func TT_moreFocusHandle(focusBtn : UIButton){
        if delegate?.TT_MoreFocusHandle() != nil{
            delegate?.TT_MoreFocusHandle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        CreateUI()
        
    }
    
    public func CreateUI(){
        addSubview(centerImgView)
        centerImgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bounds.size.height/2-180)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(180)
        }
        
        addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(centerImgView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(centerImgView)
            make.height.equalTo(20)
        }
        
        addSubview(focusBtn)
        focusBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tipLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    override func layoutSubviews() {
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

