//
//  OBCreditCardInfoRequest.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

class OBCreditCardInfoRequest {
    
    var rqUID: String! //Уникальный идентификатор документа
    var cardName: String! //Название карты
    
    init(rqUID: String, cardName: String?) {
        self.rqUID = rqUID
        self.cardName = cardName ?? ""
    }

}
