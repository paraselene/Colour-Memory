//
//  ColourMemoryHighScoreTableViewCell.swift
//  Colour Memory
//
//  Created by Alex Fung on 21/6/2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class ColourMemoryHighScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
