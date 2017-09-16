//
//  MyCard.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

class OBMyCard {
    
    var name: String = "" //Название карты
    var type: String = "" //Тип карты = ['debit', 'credit'],
    var paymentSystem: String = "" //Тип платежной системы = ['visa', 'mastercard', 'mir'],
    var id: Int! //индентификатор
    
    var depositRate: String? // Процент на остаток
    var creditRate: String? // Процент за пользование кредитными средствами
    var gracePeriod: String? // Льготный период пользования кредитным средствами
    
    var balances: [OBCardBalance] = []
    var transactions: [OBCardTransaction] = []
}

class OBCardBalance {
    
    var value: Int = 0 // Значение баланс
    var cur: String = "" //Валюта
    
}

class OBCardTransaction {
    
    var transactionDate: String = "" // Дата транзакции
    var transactionPlace: String = "" // Место транзакции
    var transactionSum: Int = 0 // Сумма транзакции
    var transactionCur: String = "" // Валюта транзакции
    
}
