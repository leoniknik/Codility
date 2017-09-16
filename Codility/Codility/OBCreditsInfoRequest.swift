//
//  OBCreditInfoRequest.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

class OBCreditsInfoRequest {
    
    var rqUID: String = ""
    var creditName: String = ""
    
    init(rqUID: String, creditName: String?) {
        self.rqUID = rqUID
        self.creditName = creditName ?? ""
    }
    
}
