//
//  OBMyCardBalanceResponse.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class OBMyCardBalanceResponse {
    
    var card: OBMyCard!
    var json: JSON!
    
    var errorCode: String = ""
    var errorDescription: String = ""
    
    init(json: JSON) {
        
        self.json = json
        self.errorCode = json["ErrorCode"].string ?? ""
        self.errorDescription = json["ErrorDescription"].string ?? ""
        
        let card = OBMyCard()
        card.id = json["CardId"].int! // временная строчка
        
        for item in json["CardBalance"].arrayValue {
            let newBalance = OBCardBalance()
            newBalance.value = item["Value"].int ?? 0
            newBalance.cur = item["Cur"].string ?? ""
            card.balances.append(newBalance)
        }
        
        self.card = card
    }
    
}
