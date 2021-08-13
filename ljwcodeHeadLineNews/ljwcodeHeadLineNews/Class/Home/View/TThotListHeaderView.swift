//
//  TThotListHeaderView.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/11.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import Foundation
import UIKit

class TThotListHeaderView : UIView,UIGestureRecognizerDelegate{
    private let hspace = 10
    private let vspace = 10
    private let kScreenWidth = UIScreen.main.bounds.width
    
    private lazy var countryView : UIView = {
        let countryView = UIView()
        countryView.backgroundColor = UIColor.gray
        let tapCountryGesture = UITapGestureRecognizer.init(target: self, action: #selector(TT_tapCountryhandle))
        tapCountryGesture.delegate = self
        return countryView
    }()
    
    private lazy var localView : UIView = {
        let localView = UIView()
        localView.backgroundColor = UIColor.gray
        let tapLocalGesture = UITapGestureRecognizer.init(target: self, action: #selector(TT_tapLocalHandle))
        tapLocalGesture.delegate = self
        return localView
    }()
    
    private lazy var leftCountryTitleLabel : UILabel = {
        let leftCountryTitleLabel = UILabel()
        leftCountryTitleLabel.text = "全国疫情"
        leftCountryTitleLabel.textColor = UIColor.gray
        leftCountryTitleLabel.textAlignment = NSTextAlignment.center
        leftCountryTitleLabel.adjustsFontSizeToFitWidth = true
        leftCountryTitleLabel.font = UIFont.systemFont(ofSize: 10)
        return leftCountryTitleLabel
    }()
    
    private lazy var leftTipBtn : UIButton = {
        let leftTipBtn = UIButton()
        leftTipBtn .setImage(UIImage.init(named: ""), for: UIControl.State.normal)
        leftTipBtn .addTarget(self, action: #selector(TT_TipHandle), for: .touchUpInside)
        return leftTipBtn
    }()
    
    private lazy var rightLocalTitleLabel : UILabel = {
        let rightLocalTitleLabel = UILabel()
        rightLocalTitleLabel.text = ""
        rightLocalTitleLabel.textColor = UIColor.gray
        rightLocalTitleLabel.textAlignment = NSTextAlignment.center
        rightLocalTitleLabel.adjustsFontSizeToFitWidth = true
        rightLocalTitleLabel.font = UIFont.systemFont(ofSize: 10)
        return rightLocalTitleLabel
    }()
    
    private lazy var rightTipBtn : UIButton = {
       let rightTipBtn = UIButton()
        rightTipBtn .setImage(UIImage.init(named: ""), for: UIControl.State.normal)
        rightTipBtn .addTarget(self, action: #selector(TT_TipHandle), for: .touchUpInside)
        return rightTipBtn
    }()
    
    private lazy var leftNewNumLabel : UILabel = {
        let leftNewNumLabel = UILabel()
        leftNewNumLabel.text = ""
        leftNewNumLabel.textColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        leftNewNumLabel.font = UIFont.systemFont(ofSize: 16)
        leftNewNumLabel.textAlignment = NSTextAlignment.center
        leftNewNumLabel.adjustsFontSizeToFitWidth = true
        return leftNewNumLabel
    }()
    
    private lazy var leftNewNumTipLabel : UILabel = {
        let leftNewNumTipLabel = UILabel()
        leftNewNumTipLabel.text = "本土昨日新增"
        leftNewNumTipLabel.textColor = UIColor.black
        leftNewNumTipLabel.font = UIFont.systemFont(ofSize: 10)
        leftNewNumTipLabel.textAlignment = NSTextAlignment.center
        leftNewNumTipLabel.adjustsFontSizeToFitWidth = true
        return leftNewNumTipLabel
    }()
    
    private lazy var leftHadNumLabel : UILabel = {
        let leftHadNumLabel = UILabel()
        leftHadNumLabel.text = ""
        leftHadNumLabel.textColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        leftHadNumLabel.font = UIFont.systemFont(ofSize: 16)
        leftHadNumLabel.textAlignment = NSTextAlignment.center
        leftHadNumLabel.adjustsFontSizeToFitWidth = true
        return leftHadNumLabel
    }()
    
    private lazy var leftHadNumTipLabel : UILabel = {
        let leftHadNumTipLabel = UILabel()
        leftHadNumTipLabel.text = "本土现有确诊"
        leftHadNumTipLabel.textColor = UIColor.black
        leftHadNumTipLabel.font = UIFont.systemFont(ofSize: 10)
        leftHadNumTipLabel.textAlignment = NSTextAlignment.center
        leftHadNumTipLabel.adjustsFontSizeToFitWidth = true
        return leftHadNumTipLabel
    }()
    
    private lazy var rightNewNumLabel : UILabel = {
        let rightNewNumLabel = UILabel()
        rightNewNumLabel.text = ""
        rightNewNumLabel.textColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        rightNewNumLabel.font = UIFont.systemFont(ofSize: 16)
        rightNewNumLabel.textAlignment = NSTextAlignment.center
        rightNewNumLabel.adjustsFontSizeToFitWidth = true
        return rightNewNumLabel
    }()
    
    private lazy var rightNewNumTipLabel : UILabel = {
        let rightNewNumTipLabel = UILabel()
        rightNewNumTipLabel.text = "本土昨日新增"
        rightNewNumTipLabel.textColor = UIColor.black
        rightNewNumTipLabel.font = UIFont.systemFont(ofSize: 10)
        rightNewNumTipLabel.textAlignment = NSTextAlignment.center
        rightNewNumTipLabel.adjustsFontSizeToFitWidth = true
        return rightNewNumTipLabel
    }()
    
    private lazy var rightHadNumLabel : UILabel = {
        let rightHadNumLabel = UILabel()
        rightHadNumLabel.text = ""
        rightHadNumLabel.textColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        rightHadNumLabel.font = UIFont.systemFont(ofSize: 16)
        rightHadNumLabel.textAlignment = NSTextAlignment.center
        rightHadNumLabel.adjustsFontSizeToFitWidth = true
        return rightHadNumLabel
    }()
    
    private lazy var rightHadNumTipLabel : UILabel = {
        let rightHadNumTipLabel = UILabel()
        rightHadNumTipLabel.text = "本土现有确诊"
        rightHadNumTipLabel.textColor = UIColor.black
        rightHadNumTipLabel.font = UIFont.systemFont(ofSize: 10)
        rightHadNumTipLabel.textAlignment = NSTextAlignment.center
        rightHadNumTipLabel.adjustsFontSizeToFitWidth = true
        return rightHadNumTipLabel
    }()
    
    
    private lazy var midLineView : UIView = {
        let midLineView = UIView()
        midLineView.backgroundColor = UIColor.gray
        return midLineView
    }()
    
    
    @objc func TT_tapCountryhandle(tapCountryGesture : UITapGestureRecognizer){
        
    }
    
    @objc func TT_tapLocalHandle(tapLocalGesture : UITapGestureRecognizer){
        
    }
    
    @objc func TT_TipHandle(rightTipBtn : UIButton){
        
    }
    
    public func CreateUI(){
        addSubview(countryView)
        countryView.snp.makeConstraints { (make) in
            make.left.equalTo(vspace)
            make.top.equalTo(hspace)
            make.width.equalTo(kScreenWidth/2 - CGFloat(hspace) * 4.5)
            make.height.equalTo(self.bounds.size.height * 0.6)
        }
        
        addSubview(localView)
        localView.snp.makeConstraints { (make) in
            make.left.equalTo(countryView.snp.right).offset(hspace/2)
            make.top.equalTo(countryView)
            make.width.height.equalTo(countryView)
        }
        
        countryView.addSubview(leftCountryTitleLabel)
        leftCountryTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hspace/2)
            make.left.equalTo(vspace/2)
            make.height.equalTo(10)
            make.width.equalTo((kScreenWidth/2 - CGFloat(hspace) * 4.5) * 0.4)
        }
        
        countryView.addSubview(leftTipBtn)
        leftTipBtn.snp.makeConstraints { (make) in
            make.left.equalTo(leftCountryTitleLabel.snp.right).offset(3)
            make.top.equalTo(leftCountryTitleLabel)
            make.width.height.equalTo(10)
        }
        
        countryView.addSubview(leftNewNumLabel)
        leftNewNumLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftCountryTitleLabel)
            make.top.equalTo(countryView.center)
            make.width.bottom.equalTo(leftCountryTitleLabel)
            make.height.equalTo(20)
        }
        
        countryView.addSubview(leftNewNumTipLabel)
        leftNewNumTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftNewNumLabel)
            make.top.equalTo(leftNewNumLabel.snp.bottom).offset(3)
            make.width.equalTo(leftNewNumLabel)
            make.height.equalTo(10)
        }
        
        
        countryView.addSubview(midLineView)
        midLineView.snp.makeConstraints { (make) in
            make.left.equalTo(leftTipBtn.snp.bottom).offset(10)
            make.centerX.equalTo(countryView)
            make.width.equalTo(1)
            make.height.equalTo(leftNewNumLabel.bounds.height + leftNewNumTipLabel.bounds.height + 3)
        }
        
        countryView.addSubview(leftHadNumLabel)
        leftHadNumLabel.snp.makeConstraints { (make) in
            make.left.equalTo(midLineView.snp.right).offset(hspace/2)
            make.top.equalTo(leftNewNumLabel)
            make.width.height.equalTo(leftNewNumLabel)
        }
        
        countryView.addSubview(leftHadNumTipLabel)
        leftHadNumTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftHadNumLabel)
            make.top.equalTo(leftNewNumTipLabel)
            make.width.height.equalTo(leftNewNumTipLabel)
        }
        
        
        localView.addSubview(rightLocalTitleLabel)
        rightLocalTitleLabel.snp.makeConstraints { (make) in
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
}
