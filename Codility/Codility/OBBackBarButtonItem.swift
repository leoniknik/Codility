//
//  OBBackBarButtonItem.swift
//  Codility
//
//  Created by Кирилл Володин on 14.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit

class OBBackBarButtonItem: UIBarButtonItem {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.image = UIImage.OBImage.backward
        self.tintColor = UIColor.white
        
    }
    
}
