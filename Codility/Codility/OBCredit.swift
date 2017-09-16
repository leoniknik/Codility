//
//  Credit.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import Foundation

class OBCredit {
    
    var name: String = "" // Название кредита
    var minSum: String = "" // Минимальная сумма по кредиту
    var maxSum: String = "" // Максимальная сумма по кредиту
    var minTerm: String = "" // Минимальный срок кредита, мес
    var maxTerm: String = "" // Максимальный срок кредита, мес
    
    var rates: [CreditRate] = []
    
    var url: String = "" // Ссылка на описание кредита
    var description: String = "" // Описание кредита
    
}

class CreditRate {
    
    var minTerm: String? // Планируемый срок кредита, мес
    var termRate: String? // Ставка по кредиту для планируого срока

}
