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
                "Deposits": [
                "Deposit": [
                [
                "DepositName": "Доходный",
                "DepositMinSum": "10000",
                "DepositMinTermRate": "6",
                "DepositMaxTermRate": "60",
                "Rates": [
                [
                "Rate": [
                [
                "DepositSum": "20000",
                "DepositTermRate": "16"
                ],
                [
                "DepositSum": "15000",
                "DepositTermRate": "15"
                ]
                ]
                ]
                ]
                ],
                [
                "DepositName": "Выгодный",
                "DepositMinSum": "100000",
                "DepositMinTermRate": "12",
                "DepositMaxTermRate": "120",
                "DepositCapitalisation": "12",
                "Rates": [
                [
                "Rate": [
                [
                "DepositSum": "100000",
                "DepositTermRate": "15"
                ]
                ]
                ]
                ]
                ]
                ]
                ]
        ]
        
        let request = OBCreditCardInfoRequest(rqUID: "123e4567-e89b-12d3-a456-426655440000", cardName: "")
        
        OBAPIManager.creditCardsInfoRequest(request: request)
    }

    @IBAction func goBack(_ sender: OBBackBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
