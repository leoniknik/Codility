//
//  OBCreditInfoResponse.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class OBCreditsInfoResponse {
        
    var rqUID: String?
    var credits: [OBCredit] = []
    var json: JSON!

    init(json: JSON) {
        self.json = json
        self.rqUID = json["RqUID"].string
        for item in json["Credits"].arrayValue {
            let credit = OBCredit()
            credit.name = item["CreditName"].string!
            credit.minSum = item["CreditMinSum"].string!
            credit.maxSum = item["CreditMaxSum"].string!
            credit.minTerm = item["CreditMinTerm"].string!
            credit.maxTerm = item["CreditMaxTerm"].string!
            credit.url = item["CreditUrl"].string!
            credit.description = item["CreditDescription"].string!
            for rate in item["Rates"].arrayValue {
                let newRate = CreditRate()
                newRate.minTerm = "\(rate["credit_min_term"].int)"
                newRate.termRate = "\(rate["credit_term_rate"].int)"
                credit.rates.append(newRate)
            }
            credits.append(credit)
        }
    }

}
