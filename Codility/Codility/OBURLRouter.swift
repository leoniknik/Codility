//
//  OBURLRouter.swift
//  Codility
//
//  Created by Кирилл Володин on 15.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

class OBURLRouter {
    
    static let baseURL = "https://api.open.ru/creditcardinfo/1.0.0"
    
    static let getCreditCardsInfoURL = "\(baseURL)/CreditCards/info"
    static let getCreditCardsCallbackURL = "\(baseURL)/CreditCards/callback"
    static let getCreditInfoURL = "\(baseURL)/Credits/info"
    
}
