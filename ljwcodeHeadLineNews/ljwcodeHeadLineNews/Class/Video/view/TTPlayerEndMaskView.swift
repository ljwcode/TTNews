//
//  TTPlayerEndMaskView.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/3/17.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import UIKit
import SnapKit

class TTPlayerEndMaskView : UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black
        self.alpha = 0.5
        
    }
    public func createUI(){
        
    }
    
    override func layoutSubviews() {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
