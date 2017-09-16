//
//  OBTransferConfirmCell.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit

class OBTransferConfirmCell: UITableViewCell {

    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var createLinkButton: UIButton!
    @IBOutlet weak var confirmTransferButton: UIButton!
    @IBOutlet weak var createQRCodeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
