//
//  SSThemedLabel.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/1.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit

class SSThemedLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 1
        textAlignment = NSTextAlignment.center
//        lineBreakMode = NSLineBreakMode.byTruncatingTail
//        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
