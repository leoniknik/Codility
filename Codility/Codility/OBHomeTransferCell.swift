//
//  OBHomeTransferCell.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit

class OBHomeTransferCell: UITableViewCell {

    @IBOutlet weak var selfTransferButton: UIButton!
    
    @IBOutlet weak var phoneTransferButton: UIButton!
    
    @IBOutlet weak var organisationTransferButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
