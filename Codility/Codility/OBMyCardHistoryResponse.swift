//
//  OBMyCardHistoryResponse.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class OBMyCardHistoryResponse {
    
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
        
        for item in json["CardTransactionsList"].arrayValue {
            let newTransaction = OBCardTransaction()
            newTransaction.transactionSum = item["TransactionSum"].int ?? 0
            newTransaction.transactionCur = item["TransactionCur"].string ?? ""
            newTransaction.transactionDate = item["TransactionDate"].string ?? ""
            newTransaction.transactionPlace = item["TransactionPlace"].string ?? ""
            card.transactions.append(newTransaction)
        }
        
        self.card = card
    }
    

    
}
