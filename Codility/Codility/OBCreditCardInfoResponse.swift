//
//  CardInfoResponse.swift
//  Codility
//
//  Created by Кирилл Володин on 15.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class OBCreditCardInfoResponse {
    
    var rqUID: String?
    var cards: [Card] = []
    var json: JSON!
    
    init(json: JSON) {
        self.json = json
        self.rqUID = json["RqUID"].string
        for item in json["Cards"]["Card"].arrayValue {
            let card = Card()
            card.name = item["CardName"].string!
            card.type = item["CardType"].string!
            card.paymentSystem = item["CardPaymentSystem"].string!
            card.description = item["CardDescription"].string!
            cards.append(card)
        }
    }
    
}
