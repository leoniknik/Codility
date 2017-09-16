//
//  OBTransefType.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

struct OBTransferType {
    
    static var transferType: TransferType = .selfTransfer
    
    enum TransferType {
        case selfTransfer
        case phoneTransfer
        case organisationTransfer
    }
    
}
