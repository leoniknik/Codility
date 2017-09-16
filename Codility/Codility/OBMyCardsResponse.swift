//
//  OBMyCardsResponse.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class OBMyCardsResponse {

    var cards: [OBMyCard] = []
    var json: JSON!
    
    init(json: JSON) {
        self.json = json
        for item in json["Cards"]["Card"].arrayValue {
            let card = OBMyCard()
            card.name = item["CardName"].string!
            card.type = item["CardType"].string!
            card.paymentSystem = item["CardPaymentSystem"].string!
            card.id = Int(item["CardId"].string!) ?? 0
            cards.append(card)
        }
    }

}
