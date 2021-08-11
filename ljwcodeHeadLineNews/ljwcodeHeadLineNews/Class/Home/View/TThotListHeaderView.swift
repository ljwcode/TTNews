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
