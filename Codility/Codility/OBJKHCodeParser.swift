//
//  OBJKHCodeParser.swift
//  OpenBank
//
//  Created by Aleksander Evtuhov on 17/09/2017.
//  Copyright © 2017 Aleksander Evtuhov. All rights reserved.
//

import Foundation

class OBJKHCodeParser{
    
    static var ex = "ST00012|Name=Филиал \"КолАтомЭнергоСбыт\" АтомЭнергоСбыт|PersonalAcc=40702810300010006644| BankName=Центральный филиал АБ РОССИЯ|BIC=044599132|CorrespAcc=30101810400000000132|PersAcc=514100595728|Sum=49208|PayeeINN=519043001|PayerINN=519043001|PaymPeriod=СЕНТЯБРЬ 2015|TechCode=02"
    
    
    static func validateCode(code: String) -> Bool {
        
        return  code.contains("PersonalAcc=") &&
                code.contains("BankName=") &&
                code.contains("PayerINN=") &&
                code.contains("Sum=") &&
                code.contains("BIC=") &&
                code.contains("CorrespAcc=")
    }
    
    
    
    static func getAccountDictionary(code:String)->Dictionary<String, String>{
        
        var mapperDictionary: Dictionary<String, String> = [
            "INNTextFieled" : "PayerINN=",
            "accountTextFieled" : "PersonalAcc=",
            "BIKtextFieled" : "BIC=",
            "corpAccountTextFieled" : "CorrespAcc=",
            "bankNameTextFieled" : "BankName=",
            "sumTextFieled" : "Sum="
        ]
        
        var accountDictionary: Dictionary<String, String> = [
            "INNTextFieled" : "",
            "accountTextFieled" : "",
            "BIKtextFieled" : "",
            "corpAccountTextFieled" : "",
            "bankNameTextFieled" : "",
            "sumTextFieled" : ""
        ]
        
        var parameterStringArray = code.components(separatedBy: "|")
        
        for key in accountDictionary.keys{
            var mappedParameterName = mapperDictionary[key]
            for varString in parameterStringArray{
                if varString.contains(mappedParameterName!){
                    accountDictionary[key] = varString.replacingOccurrences(of: mappedParameterName!, with: "")
                }
            }
        }
        
        return accountDictionary
    }
    
    static func parseCode(code:String)->Dictionary<String, String>?{
        if(validateCode(code: code)){
            return getAccountDictionary(code:code)
        }else{
            return nil
        }
    }
    
    static func test(){
        var dic = parseCode(code: ex)
        print(dic)
    }
    
}
