//
//  ChecklistTableViewCell.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/3/19.
//  Copyright © 2019 Steven QU. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {
    @IBOutlet weak var completionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
