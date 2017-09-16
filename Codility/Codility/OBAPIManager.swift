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

    private class func creditCardsInfoOnSuccess(json: JSON) -> Void {
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
    
    private class func creditsInfoOnSuccess(json: JSON) -> Void {
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
    
    private class func depositsInfoOnSuccess(json: JSON) -> Void {
        print(json)
        let response = OBDepositsInfoResponse(json: json)
        NotificationCenter.default.post(name: .depositsInfoCallback, object: nil, userInfo: ["data": response])
    }
    
    
    class func myCardsRequest() -> Void {
        
        let parameters: Parameters = [
            :
        ]
        
        self.request(URL: OBURLRouter.getMyCardsURL, method: .get, parameters: parameters, onSuccess: myCardsOnSuccess, onError: defaultOnError)
        
    }
    
    private class func myCardsOnSuccess(json: JSON) -> Void {
        print(json)
        let response = OBMyCardsResponse(json: json)
        NotificationCenter.default.post(name: .myCardsCallback, object: nil, userInfo: ["data": response])
    }
    
    
    class func myCardInfoRequest(request: OBMyCardInfoRequest) -> Void {
        
        let parameters: Parameters = [
            "CardId": request.id
        ]
        
        self.request(URL: OBURLRouter.getMyCardInfoURL, method: .post, parameters: parameters, onSuccess: myCardInfoOnSuccess, onError: defaultOnError)
        
    }
    
    private class func myCardInfoOnSuccess(json: JSON) -> Void {
        print(json)
        let response = OBMyCardInfoResponse(json: json)
        NotificationCenter.default.post(name: .myCardInfoCallback, object: nil, userInfo: ["data": response])
    }
    
    //balance
    class func myCardBalanceRequest(request: OBMyCardBalanceRequest) -> Void {
        
        let parameters: Parameters = [
            "CardId": request.id
        ]
        
        self.request(URL: OBURLRouter.getMyCardBalanceURL, method: .post, parameters: parameters, onSuccess: myCardBalanceOnSuccess, onError: defaultOnError)
        
    }
    
    private class func myCardBalanceOnSuccess(json: JSON) -> Void {
        print(json)
        let response = OBMyCardBalanceResponse(json: json)
        NotificationCenter.default.post(name: .myCardBalanceCallback, object: nil, userInfo: ["data": response])
    }
    
    
    //history
    class func myCardHistoryRequest(request: OBMyCardHistoryRequest) -> Void {
        
        let parameters: Parameters = [
            "CardId": request.id
        ]
        
        self.request(URL: OBURLRouter.getMyCardHistoryURL, method: .post, parameters: parameters, onSuccess: myCardHistoryOnSuccess, onError: defaultOnError)
        
    }
    
    private class func myCardHistoryOnSuccess(json: JSON) -> Void {
        print(json)
        let response = OBMyCardHistoryResponse(json: json)
        NotificationCenter.default.post(name: .myCardHistoryCallback, object: nil, userInfo: ["data": response])
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
