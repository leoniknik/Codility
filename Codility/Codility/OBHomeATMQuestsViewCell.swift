//
//  OBHomeATMQuestsViewCell.swift
//  Codility
//
//  Created by Aleksander Evtuhov on 17/09/2017.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit

class OBHomeATMQuestsViewCell: UITableViewCell {

    @IBOutlet weak var questsButton: UIButton!
    
    @IBOutlet weak var ATMOutletButton: UIButton!
    
    @IBOutlet weak var QRCodeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
