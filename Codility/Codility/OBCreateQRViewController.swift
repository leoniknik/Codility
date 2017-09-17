//
//  OBCreateQRViewController.swift
//  Codility
//
//  Created by Кирилл Володин on 17.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit
import QRCode

class OBCreateQRViewController: UIViewController {

    @IBOutlet weak var QRImage: UIImageView!
    @IBOutlet weak var pushButton: UIButton!
    
    var encodedData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pushButton.layer.cornerRadius = 10
        pushButton.clipsToBounds = true
        generateQR()
    }

    func generateQR() {
            let url = encodedData
            let prefix = "bank://"
            let fullUrl = URL(string: prefix.appending(url))
            let qrCode = QRCode(fullUrl!)
            QRImage.image = qrCode?.image
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
