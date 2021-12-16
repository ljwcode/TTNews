//
//  SearchTracelessSwitchView.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/10/11.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SearchTracelessSwitchView : UIView {
    private lazy var TTSettingSwitch : UISwitch = {
        let TTSettingSwitch = UISwitch()
        TTSettingSwitch.isOn = false
        TTSettingSwitch.onTintColor = UIColor.green
        return TTSettingSwitch
    }()
    
    private lazy var tipLabel : UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "无痕搜索模式"
        tipLabel.textColor = UIColor.black
        tipLabel.font = UIFont.systemFont(ofSize: 15)
        tipLabel.textAlignment = NSTextAlignment.center
        return tipLabel
    }()
    
    
    func createUI() -> Void{
        addSubview(TTSettingSwitch)
        TTSettingSwitch.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(50)
        }
        
        addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(90)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
