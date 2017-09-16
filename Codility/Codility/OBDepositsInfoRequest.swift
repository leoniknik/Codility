//
//  OBDepositssInfoRequest.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

class OBDepositsInfoRequest {
    
    var rqUID: String = ""
    var depositName: String = ""
    
    init(rqUID: String, depositName: String?) {
        self.rqUID = rqUID
        self.depositName = depositName ?? ""
    }
    
}
