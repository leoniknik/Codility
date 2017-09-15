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
            "Cards": [
                "Card": [
                [
                "CardName": "Кредитная",
                "CardType": "credit",
                "CardPaymentSystem": "visa",
                "CardDescription": "Кредитная карта",
                "CardURL": "http://open.ru"
                ],
                [
                "CardName": "Дебетовая",
                "CardType": "debit",
                "CardPaymentSystem": "mir",
                "CardDescription": "Дебетовая карта",
                "CardURL": "http://open.ru"
                ]
                ]
            ]
        ]
//        let response = OBCreditCardInfoResponse(json)
    }

    @IBAction func goBack(_ sender: OBBackBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
