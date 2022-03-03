//
//  TTAlphaThemedButton.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/1.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit


class TTAlphaThemeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage.init(named: "close_grade_small"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
