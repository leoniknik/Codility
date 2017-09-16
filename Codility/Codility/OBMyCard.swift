//
//  MyCard.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation
import RealmSwift

//class Playlist: Object {
//    
//    dynamic var id: Int = 0
//    dynamic var schoolName: String = ""
//    dynamic var lastUpdate: Int = 0
//    dynamic var position: Int = 0
//    dynamic var title: String = ""
//    let songs = LinkingObjects(fromType: Song.self, property: "playlist")
//    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//    
//}

class OBMyCard: Object {
    
    dynamic var name: String = "" //Название карты
    dynamic var type: String = "" //Тип карты = ['debit', 'credit'],
    dynamic var paymentSystem: String = "" //Тип платежной системы = ['visa', 'mastercard', 'mir'],
    dynamic var id: Int = 0 //индентификатор
    
    dynamic var depositRate: String? // Процент на остаток
    dynamic var creditRate: String? // Процент за пользование кредитными средствами
    dynamic var gracePeriod: String? // Льготный период пользования кредитным средствами
    
    var balances: [OBCardBalance] = []
    var transactions: [OBCardTransaction] = []
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["balances", "transactions"]
    }
    
}

class OBCardBalance: Object {
    
    var value: Int = 0 // Значение баланс
    var cur: String = "" //Валюта
    
}

class OBCardTransaction: Object {
    
    var transactionDate: String = "" // Дата транзакции
    var transactionPlace: String = "" // Место транзакции
    var transactionSum: Int = 0 // Сумма транзакции
    var transactionCur: String = "" // Валюта транзакции
    
}
