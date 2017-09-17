//
//  BankATM.swift
//  OpenBank
//
//  Created by Aleksander Evtuhov on 16/09/2017.
//  Copyright © 2017 Aleksander Evtuhov. All rights reserved.
//
//

import Foundation

class BankATM{
    var distance:Int?
    var timetable:String?
    var adress:String?
    
    init(distanceP:Int,timetableP:String,adressP:String){
        self.distance=distanceP
        self.adress=adressP
        self.timetable = timetableP
    }
    
    static func getTestData()->[BankATM]{
        var testData = [BankATM]()
        testData.append(BankATM(distanceP:100,timetableP:"пн-вс: 09:00-18:00",adressP:"ул. Уличная д.5 к.1"))
        testData.append(BankATM(distanceP:50,timetableP:"пн-вс: 09:00-18:00",adressP:"ул. Городская стр.33"))
        return testData
    }
}

class BankOutlet:BankATM{
    var workload:Int?
    var services:[Service]?
    
    init(distanceP:Int,timetableP:String,adressP:String,workloadP:Int){
        super.init(distanceP: distanceP, timetableP: timetableP, adressP: adressP)
        self.workload = workloadP
        self.services = Service.getTestData()
    }
    
    static func getTestData()->[BankOutlet]{
        var testData = [BankOutlet]()
        testData.append(BankOutlet(distanceP:1000,timetableP:"пн-вс: 09:00-18:00",adressP:"ул. Космонавта Волкова д. 14",workloadP:1))
        testData.append(BankOutlet(distanceP:800,timetableP:"пн-вс: 09:00-18:00",adressP:"ул. Бауманская д. 2",workloadP:1))
        
        return testData
    }
}
