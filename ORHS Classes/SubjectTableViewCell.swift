//
//  SubjectTableViewCell.swift
//  ORHS Classes
//
//  Created by Steven QU on 5/29/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var subjectLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
