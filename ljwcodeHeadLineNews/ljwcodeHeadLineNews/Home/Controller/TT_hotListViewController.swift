//
//  TT_hotListViewController.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/11.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import Foundation
import UIKit


class TT_hotListViewController : TTBaseViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = NSStringFromClass(TT_hotListViewController.self)
        var tableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if indexPath.section == 0 {
            if tableViewCell == nil{
                tableViewCell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
            }
            if indexPath.row == 0 {
                
            }
        }
        
        
        
        return tableViewCell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
