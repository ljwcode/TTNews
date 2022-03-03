//
//  SSThemedButton.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/10/14.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit

class SSThemedButton : UIButton {
    @objc init(frame: CGRect,textColor:UIColor,backgroundColor:UIColor,textAlign:NSTextAlignment) {
        super.init(frame: frame)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.textAlignment = textAlign
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
