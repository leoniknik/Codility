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
//
//    class func logInRequest(person: Person) -> Void {
//        
//        let parameters: Parameters = [
//            "email": person.email,
//            "password": person.password
//        ]
//        
//        request(URL: LOGIN_URL, method: .post, parameters: parameters, onSuccess: logInOnSuccess, onError: defaultOnError)
//        
//    }
//    
//    class func logInOnSuccess(json: JSON) -> Void {
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            let data = json["data"].dictionaryObject
//            NotificationCenter.default.post(name: .logInCallback, object: nil, userInfo: data)
//        }
//    }
//    
//    
//    class func getListOfVehiclesRequest() -> Void {
//        
//        let person = DataBaseHelper.getPerson()
//        
//        let parameters: Parameters = [
//            "user_id": person.id
//        ]
//        
//        request(URL: GET_LIST_OF_VEHICLES_URL, method: .get, parameters: parameters, onSuccess: getListOfVehiclesOnSuccess, onError: defaultOnError)
//    }
//    
//    class func getListOfVehiclesOnSuccess(json: JSON) -> Void{
//        
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            NotificationCenter.default.post(name: .getVehiclesCallback, object: nil, userInfo: data)
//        }
//        
//    }
//    
//    class func getListOfActualCrashesRequest(vehicle: Vehicle) -> Void {
//        
//        let parameters: Parameters = [
//            "vehicle_id": vehicle.id
//        ]
//        
//        request(URL: GET_LIST_OF_ACTUAL_CRASHES_URL, method: .get, parameters: parameters, onSuccess: getListOfActualCrashesOnSuccess, onError: defaultOnError)
//    }
//    
//    class func getListOfActualCrashesOnSuccess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            NotificationCenter.default.post(name: .getListOfCrashesCallback, object: nil, userInfo: data)
//        }
//        
//    }
//    
//    class func getListOfHistoryCrashesRequest(vehicle: Vehicle) -> Void {
//        
//        let parameters: Parameters = [
//            "vehicle_id": vehicle.id
//        ]
//        
//        request(URL: GET_LIST_OF_HISTORY_CRASHES_URL, method: .get, parameters: parameters, onSuccess:getListOfHistoryCrashesOnSuccess, onError: defaultOnError)
//    }
//    
//    class func getListOfHistoryCrashesOnSuccess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            NotificationCenter.default.post(name: .getListOfCrashesCallback, object: nil, userInfo: data)
//        }
//        
//    }
//    
//    class func getListOfOffersRequest(crash: Crash) -> Void {
//        
//        let parameters: Parameters = [
//            "crash_id": crash.id
//        ]
//        
//        request(URL: GET_LIST_OF_OFFERS_URL, method: .get, parameters: parameters, onSuccess: getListOfOffersOnSuccess, onError: defaultOnError)
//    }
//    
//    class func getListOfOffersOnSuccess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            NotificationCenter.default.post(name: .getListOfOffersCallback, object: nil, userInfo: data)
//        }
//    }
//    
//    class func getServiceRequest(offer: Offer) -> Void{
//        
//        let parameters: Parameters = [
//            "service_id": offer.service!.id
//        ]
//        
//        request(URL: GET_SERVICE_URL, method: .get, parameters: parameters, onSuccess: getServiceOnSuccess, onError: defaultOnError)
//        
//    }
//    
//    class func getServiceOnSuccess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            NotificationCenter.default.post(name: .getServiceCallback, object: nil, userInfo: data)
//        }
//    }
//    
//    class func getListOfReviewsRequest(offer: Offer) -> Void{
//        let parameters: Parameters = [
//            "service_id": offer.service!.id
//        ]
//        
//        request(URL: GET_SERVICE_REVIEWS_URL, method: .get, parameters: parameters, onSuccess: getListOfReviewsOnSuccess, onError: defaultOnError)
//        
//    }
//    
//    class func getListOfReviewsOnSuccess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            NotificationCenter.default.post(name: .getListOfReviewsCallback, object: nil, userInfo: data)
//        }
//    }
//    
//    
//    /*
//     class func editUserRequest() -> Void {
//     
//     let parameters: Parameters = [
//     "user_id": Person.instance.id!,
//     "email": Person.instance.email,
//     "password": Person.instance.password,
//     "firstname": Person.instance.firstname,
//     "lastname": Person.instance.lastname,
//     "phone": Person.instance.phone
//     ]
//     
//     request(URL: EDIT_USER_URL, method: .post, parameters: parameters, onSuccess: defaultOnSuccess, onError: defaultOnError)
//     }
//     class func addVehiclesRequest(vehicle: Vehicle) -> Void {
//     
//     let parameters: Parameters = [
//     "user_id": vehicle.id!,
//     "VIN": vehicle.VIN,
//     "number": vehicle.number,
//     "brand": vehicle.brand,
//     "model": vehicle.model,
//     "year": vehicle.year
//     ]
//     
//     request(URL: ADD_VEHICLE_URL, method: .post, parameters: parameters, onSuccess: defaultOnSuccess, onError: defaultOnError)
//     }
//     
//     class func editVehicleRequest(vehicle: Vehicle) -> Void {
//     
//     let parameters: Parameters = [
//     "user_id": vehicle.id!,
//     "VIN": vehicle.VIN,
//     "number": vehicle.number,
//     "brand": vehicle.brand,
//     "model": vehicle.model,
//     "year": vehicle.year
//     ]
//     
//     request(URL: EDIT_VEHICLE_URL, method: .post, parameters: parameters, onSuccess: defaultOnSuccess, onError: defaultOnError)
//     }
//     
//     */
//    
//    class func getListsOfVehiclesAndCrashesRequest() -> Void {
//        
//        let person = DataBaseHelper.getPerson()
//        
//        let parameters: Parameters = [
//            "user_id": person.id
//        ]
//        
//        request(URL: GET_LISTS_OF_VEHICLES_AND_CRASHES, method: .get, parameters: parameters, onSuccess: getListsOfVehiclesAndCrashesOnSuccess, onError: defaultOnError)
//    }
//    
//    
//    class func getListsOfVehiclesAndCrashesOnSuccess(json: JSON) -> Void{
//        
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            print(data)
//            NotificationCenter.default.post(name: .getListsOfVehiclesAndCrashesCallback, object: nil, userInfo: data)
//        }
//        
//    }
//    
//    
//    
//    class func getListsOfOffersAndServicesRequest(vehicle:Vehicle) -> Void {
//        //remake
//        let person = DataBaseHelper.getPerson()
//        
//        let parameters: Parameters = [
//            "user_id": person.id,
//            "vehicle_id":vehicle.id
//        ]
//        
//        request(URL: GET_LISTS_OF_OFFERS_AND_SERVICES, method: .get, parameters: parameters, onSuccess: getListsOfOffersAndServicesOnSuccess, onError: defaultOnError)
//    }
//    
//    
//    class func getListsOfOffersAndServicesOnSuccess(json: JSON) -> Void{
//        
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            print(data)
//            NotificationCenter.default.post(name: .getListsOfOffersAndServicesCallback, object: nil, userInfo: data)
//        }
//        
//    }
//    
//    class func getListsOfHighLowOffersAndServicesRequest(vehicle:Vehicle) -> Void {
//        //remake
//        let person = DataBaseHelper.getPerson()
//        
//        let parameters: Parameters = [
//            "user_id": person.id,
//            "vehicle_id":vehicle.id
//        ]
//        
//        request(URL: GET_LISTS_OF_HIGH_LOW_OFFERS_AND_SERVICES, method: .get, parameters: parameters, onSuccess: getListsOfHighLowOffersAndServicesOnSuccess, onError: defaultOnError)
//    }
//    
//    
//    class func getListsOfHighLowOffersAndServicesOnSuccess(json: JSON) -> Void{
//        
//        let code = json["code"].int!
//        if code == OK {
//            let data = json.dictionaryValue
//            print(data)
//            NotificationCenter.default.post(name: .getListsOfHighLowOffersAndServicesCallback, object: nil, userInfo: data)
//        }
//        
//    }
//    
//    
//    
//    class func setMarketMarkerRequest(vehicle:Vehicle) -> Void {
//        let parameters: Parameters = [
//            "vehicle_id": vehicle.id,
//            "is_auction": vehicle.isAuction
//        ]
//        
//        request(URL: SET_MARKET_MARKER_URL, method: .get, parameters: parameters, onSuccess: setMarketMarkerOnSuccess, onError: defaultOnError)
//    }
//    
//    
//    class func setMarketMarkerOnSuccess(json: JSON) -> Void{
//        
//        let code = json["code"].int!
//        if code == OK {
//            //let data = json.dictionaryValue
//            //print(data)
//            //NotificationCenter.default.post(name: .getListsOfOffersAndServicesCallback, object: nil, userInfo: data)
//        }
//        else{
//            //throw eror of network????
//        }
//        
//    }
//    
//    
//    class func addVehiclesRequest(vehicle: Vehicle,user:Person) -> Void {
//        
//        let parameters: Parameters = [
//            "user_id": user.id,
//            "VIN": vehicle.VIN,
//            "number": vehicle.number,
//            "brand": vehicle.brand,
//            "model": vehicle.model,
//            "year": vehicle.year
//        ]
//        
//        request(URL: ADD_VEHICLE_URL, method: .post, parameters: parameters, onSuccess: addVehiclesOnSucsess, onError: defaultOnError)
//        
//    }
//    
//    class func addVehiclesOnSucsess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            let data = json["data"].dictionaryObject
//            NotificationCenter.default.post(name: .addVehicleCallback, object: nil,userInfo: data)
//        }
//        
//    }
//    
//    class func changeVehicleRequest(vehicle: Vehicle) -> Void {
//        print("changing vehicle with id=\(vehicle.id)")
//        let parameters: Parameters = [
//            "vehicle_id":vehicle.id,
//            "VIN": vehicle.VIN,
//            "number": vehicle.number,
//            "brand": vehicle.brand,
//            "model": vehicle.model,
//            "year": vehicle.year,
//            "is_auction": vehicle.isAuction
//        ]
//        
//        request(URL: EDIT_VEHICLE_URL, method: .post, parameters: parameters, onSuccess: changeVehicleOnSucsess, onError: defaultOnError)
//        
//    }
//    
//    class func changeVehicleOnSucsess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            NotificationCenter.default.post(name: .changeVehicleCallback, object: nil,userInfo: nil)
//        }
//        
//    }
//    
//    class func deleteVehicleRequest(vehicle: Vehicle) -> Void {
//        
//        let parameters: Parameters = [
//            "vehicle_id":vehicle.id
//        ]
//        
//        request(URL: DELETE_VEHICLE_URL, method: .post, parameters: parameters, onSuccess: deleteVehicleOnSucsess, onError: defaultOnError)
//        
//    }
//    
//    class func deleteVehicleOnSucsess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            NotificationCenter.default.post(name: .deleteVehicleCallback, object: nil,userInfo: nil)
//        }
//        
//    }
//    
//    
//    
//    class func editUserRequest(user:Person) -> Void {
//        
//        let parameters: Parameters = [
//            "user_id": user.id,
//            "email": user.email,
//            "password": user.password,
//            "firstname": user.firstname,
//            "lastname": user.lastname,
//            "phone": user.phone
//        ]
//        
//        request(URL: EDIT_USER_URL, method: .post, parameters: parameters, onSuccess: editUserOnSucsess, onError: defaultOnError)
//    }
//    
//    
//    
//    class func editUserOnSucsess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            
//            NotificationCenter.default.post(name: .editUserCallback, object: nil)
//        }
//        
//    }
//    
//    class func editVehicleRequest(vehicle: Vehicle) -> Void {
//        
//        let parameters: Parameters = [
//            "user_id": vehicle.id,
//            "VIN": vehicle.VIN,
//            "number": vehicle.number,
//            "brand": vehicle.brand,
//            "model": vehicle.model,
//            "year": vehicle.year
//        ]
//        
//        request(URL: EDIT_VEHICLE_URL, method: .post, parameters: parameters, onSuccess: editVehicleOnSucsess, onError: defaultOnError)
//        
//    }
//    
//    
//    class func editVehicleOnSucsess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code == OK {
//            
//            NotificationCenter.default.post(name: .editVehicleCallback, object: nil)
//        }
//        
//    }
//    
//    class func updateHighOfferRequest(offer: HighOffer) -> Void {
//        for lowOffer in offer.lowOffers{
//            let parameters: Parameters = [
//                "id": lowOffer.id,
//                "is_chosen": lowOffer.isChosen
//            ]
//            print(parameters)
//            request(URL: UPDATE_LOW_OFFER, method: .post, parameters: parameters, onSuccess: updateHighOfferOnSucsess, onError: defaultOnError)
//        }
//        let parameters: Parameters = [
//            "id": offer.id,
//            "is_confirmed": offer.isConfirmed
//        ]
//        request(URL: UPDATE_HIGH_OFFER, method: .post, parameters: parameters, onSuccess: updateHighOfferOnSucsess, onError: defaultOnError)
//    }
//    
//    
//    class func updateHighOfferOnSucsess(json: JSON) -> Void{
//        print(json)
//        let code = json["code"].int!
//        if code != OK {
//            print("eror in updationg highOffer")
//        }
//    }
//    
//    // else code
//    
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
