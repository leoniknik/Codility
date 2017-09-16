//
//  OBMyCardInfoResponse.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class OBMyCardInfoResponse {
    
    var card: OBMyCard!
    var json: JSON!
    
    var errorCode: String = ""
    var errorDescription: String = ""
    
    init(json: JSON) {
        
        self.json = json
        self.errorCode = json["ErrorCode"].string ?? ""
        self.errorDescription = json["ErrorDescription"].string ?? ""
        let item = json["Card"]
        let card = OBMyCard()
        
        card.name = item["CardName"].string!
        card.type = item["CardType"].string!
        card.paymentSystem = item["CardPaymentSystem"].string!
        card.id = item["CardId"].int!
        
        card.depositRate = item["CardDepositRate"].string ?? ""
        card.creditRate = item["CardCreditRate"].string ?? ""
        card.gracePeriod = item["CardGracePeriod"].string ?? ""
        
        self.card = card
    }
    
}
