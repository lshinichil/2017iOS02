//
//  TimeLineTableViewCell.swift
//  sns
//
//  Created by REO HARADA on 2017/10/29.
//  Copyright © 2017年 reo harada. All rights reserved.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLineImageView: UIImageView!
    @IBOutlet weak var timeLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
