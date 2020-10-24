//
//  HomeCell.swift
//  Race to Raise
//
//  Created by ozit solutions on 01/01/20.
//  Copyright © 2020 ozit solutions. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var zonelbl: UILabel!
     @IBOutlet weak var pointlbl: UILabel!
    @IBOutlet weak var percentagelbl: UILabel!
    @IBOutlet weak var riddleslbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var continueBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
