//
//  OBCreateInvoiceResponse.swift
//  Codility
//
//  Created by Кирилл Володин on 17.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class OBCreateInvoiceResponse {

    var json: JSON!
    
    var rqUID = ""
    var invoiceCreateStatusCode = ""
    var invoiceCreateStatusDescription = ""
    
    init(json: JSON) {
        
        self.json = json
        self.rqUID = json["RqUID"].string ?? ""
        self.invoiceCreateStatusCode = json["InvoiceCreateStatusCode"].string ?? ""
        self.invoiceCreateStatusDescription = json["InvoiceCreateStatusDescription"].string ?? ""
    }
    
}
