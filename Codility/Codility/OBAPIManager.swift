//
//  OBAPIManager.swift
//  Codility
//
//  Created by Кирилл Володин on 15.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OBAPIManager {
    
    class func creditCardsInfoRequest(request: OBCreditCardInfoRequest) -> Void {
        
//        let parameters: Parameters = [
//            "RqUID": "123e4567-e89b-12d3-a456-426655440000",
//            "CardName": ""
//        ]
        
        let parameters: Parameters = [
            "RqUID": request.rqUID,
            "CardName": request.cardName
        ]
        
        self.request(URL: OBURLRouter.getCreditCardsInfoURL, method: .post, parameters: parameters, onSuccess: creditCardsInfoOnSuccess, onError: defaultOnError)
        
    }

    class func creditCardsInfoOnSuccess(json: JSON) -> Void {
        print(json)
        let response = OBCreditCardInfoResponse(json: json)
        NotificationCenter.default.post(name: .creditCardsInfoCallback, object: nil, userInfo: ["data": response])
    }
    
    
    class func creditsInfoRequest(request: OBCreditsInfoRequest) -> Void {
        
        //        let parameters: Parameters = [
        //            "RqUID": "123e4567-e89b-12d3-a456-426655440000",
        //            "CreditName": ""
        //        ]
        
        let parameters: Parameters = [
            "RqUID": request.rqUID,
            "CreditName": request.creditName
        ]
        
        self.request(URL: OBURLRouter.getCreditsInfoURL, method: .post, parameters: parameters, onSuccess: creditsInfoOnSuccess, onError: defaultOnError)
        
    }
    
    class func creditsInfoOnSuccess(json: JSON) -> Void {
        print(json)
        let response = OBCreditsInfoResponse(json: json)
        NotificationCenter.default.post(name: .creditsInfoCallback, object: nil, userInfo: ["data": response])
    }
    
    
    class func depositsInfoRequest(request: OBDepositsInfoRequest) -> Void {
        
        //        let parameters: Parameters = [
        //            "RqUID": "123e4567-e89b-12d3-a456-426655440000",
        //            "CreditName": ""
        //        ]
        
        let parameters: Parameters = [
            "RqUID": request.rqUID,
            "DepositName": request.depositName
        ]
        
        self.request(URL: OBURLRouter.getDepositsInfoURL, method: .post, parameters: parameters, onSuccess: depositsInfoOnSuccess, onError: defaultOnError)
        
    }
    
    class func depositsInfoOnSuccess(json: JSON) -> Void {
        print(json)
        let response = OBDepositsInfoResponse(json: json)
        NotificationCenter.default.post(name: .depositsInfoCallback, object: nil, userInfo: ["data": response])
    }
    

    private class func defaultOnSuccess(json: JSON) -> Void{
        print(json)
    }
    
    private class func defaultOnError(error: Any) -> Void {
        print(error)
    }
    
    private class func request(URL: String, method: HTTPMethod, parameters: Parameters, onSuccess: @escaping (JSON) -> Void , onError: @escaping (Any) -> Void) -> Void {
        Alamofire.request(URL, method: method, parameters: parameters ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                onSuccess(json)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
}
