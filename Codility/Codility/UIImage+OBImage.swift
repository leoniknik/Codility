//
//  File.swift
//  Codility
//
//  Created by Кирилл Володин on 14.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit

extension UIImage {
    
    struct OBImage {
        
        static func getCardImageForType(type: String) -> UIImage {
            switch type {
            case "mir":
                return mir
            case "visa":
                return visa
            case "masterCard":
                return masterCard
            default:
                return UIImage()
            }
        }
        
        static let backward = UIImage(named: "ic_backward")!
        
        static let mir = UIImage(named: "mir")!
        
        static let masterCard = UIImage(named: "masterCard")!
        
        static let visa = UIImage(named: "visa")!
        
        static let people = UIImage(named: "people")!
        
        static let bank = UIImage(named: "bank")!
        
        static let phone = UIImage(named: "phone")!
        
        static let peopleHome = UIImage(named: "peopleHome")!
        static let bankHome = UIImage(named: "bankHome")!
        static let phoneHome = UIImage(named: "phoneHome")!
        static let emailHome = UIImage(named: "emailHome")!
        
    }
    
}
