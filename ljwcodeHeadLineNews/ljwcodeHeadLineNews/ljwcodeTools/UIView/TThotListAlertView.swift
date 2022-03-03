//
//  TThotListAlertView.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/13.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TThotListAlertView: UIView {
    
    private lazy var topView : UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.white
        return topView
    }()
    
    private lazy var alertTipLabel : UILabel = {
        let alertTipLabel = UILabel()
        alertTipLabel.text = ""
        alertTipLabel.textColor = UIColor.black
        alertTipLabel.textAlignment = NSTextAlignment.center
        alertTipLabel.adjustsFontSizeToFitWidth = true
        alertTipLabel.font = UIFont.systemFont(ofSize: 16)
        return alertTipLabel
    }()
    
    private lazy var midLineView : UIView = {
        let midLineView = UIView()
        midLineView.backgroundColor = UIColor.gray
        return midLineView
    }()
    
    
    private lazy var bottomView : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    
    private lazy var closeAlertBtn  : UIButton = {
        let closeAlertBtn = UIButton()
        closeAlertBtn.setTitle("我知道了", for: UIControl.State.normal)
        closeAlertBtn.setTitleColor(UIColor.red, for: UIControl.State.normal)
        closeAlertBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        closeAlertBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        closeAlertBtn.addTarget(self, action: #selector(TT_clickAlertHandle), for: .touchUpInside)
        return closeAlertBtn
    }()
    
    
    @objc public func TT_clickAlertHandle(closeAlertBtn : UIButton){
        
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
