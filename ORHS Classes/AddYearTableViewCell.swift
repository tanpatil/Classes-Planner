//
//  AddYearTableViewCell.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/21/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class AddYearTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var yearLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("achoo")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
