//
//  OBCreateInvoiceRequest.swift
//  Codility
//
//  Created by Кирилл Володин on 17.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

class OBCreateInvoiceRequest {
    
    var rqUID = "23e4567-e89b-12v9-a456-426655440000"
    
    var invoiceCreateNumber = ""
    var invoiceCreateDate = ""
    var invoiceCreateSum = ""
    
    var invoiceCreatePayerINN = ""
    var invoiceCreatePayerAcc = ""
    var invoiceCreatePayerBIK = ""
    var invoiceCreatePayerCorrAcc = ""
    var invoiceCreatePayerBankname = ""
    
    var invoiceCreatePayeeINN = ""
    var invoiceCreatePayeeAcc = ""
    var invoiceCreatePayeeBIK = ""
    var invoiceCreatePayeeCorrAcc = ""
    var invoiceCreatePayeeBankname = ""
    
    init(rqUID: String, invoiceCreateSum : String, invoiceCreatePayeeINN : String, invoiceCreatePayeeAcc : String, invoiceCreatePayeeBIK : String, invoiceCreatePayeeCorrAcc : String, invoiceCreatePayeeBankname : String) {
        
        self.rqUID = rqUID
        self.invoiceCreateSum = invoiceCreateSum
        
        self.invoiceCreatePayeeINN = invoiceCreatePayeeINN
        self.invoiceCreatePayeeAcc = invoiceCreatePayeeAcc
        self.invoiceCreatePayeeBIK = invoiceCreatePayeeBIK
        self.invoiceCreatePayeeCorrAcc = invoiceCreatePayeeCorrAcc
        self.invoiceCreatePayeeBankname = invoiceCreatePayeeBankname
    }
    
}
