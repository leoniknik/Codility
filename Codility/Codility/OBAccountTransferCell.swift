//
//  OBAccountTransferCell.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit

class OBAccountTransferCell: UITableViewCell {

    @IBOutlet weak var INNTextFieled: UITextField!
    @IBOutlet weak var accountTextFieled: UITextField!
    @IBOutlet weak var BIKtextFieled: UITextField!
    @IBOutlet weak var corpAccountTextFieled: UITextField!
    @IBOutlet weak var bankNameTextFieled: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
