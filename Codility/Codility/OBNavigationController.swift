//
//  OBNavigationController.swift
//  Codility
//
//  Created by Кирилл Володин on 14.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit

class OBNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func setupNavigationBar() {
        
        self.navigationBar.tintColor = .white
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationBar.barTintColor = UIColor.OBColor.cyan
        
    }
}
