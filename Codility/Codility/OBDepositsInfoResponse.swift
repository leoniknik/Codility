//
//  OBDepositssInfoResponse.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class OBDepositsInfoResponse {
    
//    {
//    "RqUID": "123e4567-e89b-12d3-a456-426655440000",
//    "Deposits": {
//    "Deposit": [
//    {
//    "DepositName": "Доходный",
//    "DepositMinSum": "10000",
//    "DepositMinTermRate": "6",
//    "DepositMaxTermRate": "60",
//    "Rates": [
//    {
//    "Rate": [
//    {
//    "DepositSum": "20000",
//    "DepositTermRate": "16"
//    },
//    {
//    "DepositSum": "15000",
//    "DepositTermRate": "15"
//    }
//    ]
//    }
//    ]
//    },
//    {
//    "DepositName": "Выгодный",
//    "DepositMinSum": "100000",
//    "DepositMinTermRate": "12",
//    "DepositMaxTermRate": "120",
//    "DepositCapitalisation": "12",
//    "Rates": [
//    {
//    "Rate": [
//    {
//    "DepositSum": "100000",
//    "DepositTermRate": "15"
//    }
//    ]
//    }
//    ]
//    }
//    ]
//    }
//    }
    
    var rqUID: String?
    var deposits: [OBDeposit] = []
    var json: JSON!
    
    init(json: JSON) {
        self.json = json
        self.rqUID = json["RqUID"].string
        for item in json["Deposits"]["Deposit"].arrayValue {
            let deposit = OBDeposit()
            deposit.name = item["DepositName"].string ?? ""
            deposit.minSum = item["DepositMinSum"].string ?? ""
            deposit.minTerm = item["DepositMinTermRate"].string ?? ""
            deposit.maxTerm = item["DepositMaxTermRate"].string ?? ""
            deposit.сapitalisation = item["DepositCapitalisation"].string ?? ""
            deposit.url = item["DepositUrl"].string ?? ""
            deposit.description = item["DepositDescription"].string ?? ""
            for rate in item["Rates"].arrayValue {
                for rawRate in rate["Rate"].arrayValue {
                    let newRate = DepositRate()
                    newRate.minTerm = rawRate["DepositSum"].string ?? ""
                    newRate.termRate = rawRate["DepositTermRate"].string ?? ""
                    deposit.rates.append(newRate)
                }
            }
            deposits.append(deposit)
        }
    }
    
}
