//
//  OBQuest.swift
//  OpenBank
//
//  Created by Aleksander Evtuhov on 17/09/2017.
//  Copyright © 2017 Aleksander Evtuhov. All rights reserved.
//

import Foundation
class OBQuest{
    var name : String
    var howToAchive : String
    var reward : Int
    var stage : Int
    var progressMax : Int
    var progressCurent : Int
    
    init(nameP : String, howToAchiveP : String, rewardP : Int, stageP : Int, progressMaxP : Int, progressCurentP : Int){
        self.name = nameP
        self.howToAchive = howToAchiveP
        self.reward = rewardP
        self.stage = stageP
        self.progressMax = progressMaxP
        self.progressCurent = progressCurentP
    }
    
    static func getTestData()->[OBQuest]{
        var quests = [OBQuest]()
        
        quests.append(OBQuest(nameP: "Вклады", howToAchiveP: "Открой вклад", rewardP: 200, stageP: 0, progressMaxP: 1, progressCurentP: 0))
        quests.append(OBQuest(nameP: "Кредиты", howToAchiveP: "Возьми 2 кредита", rewardP: 500, stageP: 1, progressMaxP: 2, progressCurentP: 1))
        quests.append(OBQuest(nameP: "Покупки", howToAchiveP: "Потрать 30 000 на покупки", rewardP: 100, stageP: 2, progressMaxP: 30000, progressCurentP: 10000))
        quests.append(OBQuest(nameP: "Опрос", howToAchiveP: "Прими участие в опросе", rewardP: 13, stageP: 3, progressMaxP: 1, progressCurentP: 1))
        return quests
    }
}
