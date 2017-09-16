//
//  Deposit.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

class OBDeposit {
    
    var name: String = ""
    var minSum: String = ""
    var minTerm: String = ""
    var maxTerm: String = ""
    
    var rates: [DepositRate] = []
    
    var сapitalisation: String = ""
    var url: String = ""
    var description: String = ""
    
}

class DepositRate {
    
    var minTerm: String?
    var termRate: String?
    
}

