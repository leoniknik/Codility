//
//  OBHomeViewController.swift
//  Codility
//
//  Created by Кирилл Володин on 14.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit
import SwiftyJSON

class OBHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
//        OBAPIManager.getCreditCardsInfoRequest()
        //
        let json: JSON = [
            "RqUID": "123e4567-e89b-12d3-a456-426655440000",
            "Credits": [
            [
            "CreditName": "Наличными",
            "CreditMinSum": "50000",
            "CreditMaxSum": "500000",
            "CreditMinTerm": "3",
            "CreditMaxTerm": "36",
            "Rates": [
            [
            "credit_min_term": 6,
            "credit_term_rate": 14
            ],
            [
            "credit_min_term": 12,
            "credit_term_rate": 15
            ],
            [
            "credit_min_term": 24,
            "credit_term_rate": 16
            ]
            ],
            "CreditUrl": "https://open.ru",
            "CreditDescription": "Кредит наличными, сдесь и сейчас!"
            ]
            ]
        ]
        let response = OBCreditInfoResponse(json: json)
    }

    @IBAction func goBack(_ sender: OBBackBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
