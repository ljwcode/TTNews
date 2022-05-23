//
//  homeNewshotSpotModel.swift
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/8/27.
//  Copyright © 2021 ljwcode. All rights reserved.
//

import HandyJSON

struct hotSpot : HandyJSON {
    var hot_board_items = ""
}

struct hot_board_items : HandyJSON {
    
    var id = ""
    var id_str = ""
    var log_pb = [LOG_PB]()
    var title = ""
    var title_label_desc = ""
    var title_label_image = ""
    var height : Int = 0
    var image_type = ""
    var url = ""
    var width : Int = 0
    var title_label_type = ""
    
}

struct LOG_PB : HandyJSON {
    var cluster_type = ""
    var entrance_hotspot = ""
    var first_group_id = ""
    var impr_id = ""
    var location = ""
    var style_id = ""
}
