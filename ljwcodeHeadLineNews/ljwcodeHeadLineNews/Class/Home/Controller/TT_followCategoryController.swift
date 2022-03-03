//
//  TT_followCategoryController.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/10.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import Foundation
import UIKit

class TT_followCategoryController: TTBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private lazy var followEmptyView : TTFollowCategoryEmptyView = {
        let followEmptyView = TTFollowCategoryEmptyView.init(frame: self.view.bounds)
        followEmptyView.backgroundColor = UIColor.white
        return followEmptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view .addSubview(followEmptyView)
        
    }
}
