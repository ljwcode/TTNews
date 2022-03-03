//
//  SSThemedLabel.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/1.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit

class SSThemedLabel: UILabel {
    @objc public init(frame: CGRect,fontColor:UIColor,fontSize:CGFloat,align:NSTextAlignment) {
        super.init(frame: frame)
        textAlignment = align
        textColor = fontColor
        font = UIFont.systemFont(ofSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
