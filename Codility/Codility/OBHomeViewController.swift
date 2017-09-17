//
//  OBHomeViewController.swift
//  Codility
//
//  Created by Кирилл Володин on 14.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit
import RealmSwift


class OBHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let headers = ["Мои карты"]
    
    var cards: Results<OBMyCard> = OBDatabaseManager.getCards()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "OBCardCell", bundle: nil), forCellReuseIdentifier: "OBCardCell")
        self.tableView.register(UINib(nibName: "OBSectionHeaderCell", bundle: nil), forCellReuseIdentifier: "OBSectionHeaderCell")
        self.tableView.register(UINib(nibName: "OBHomeTransferCell", bundle: nil), forCellReuseIdentifier: "OBHomeTransferCell")
    }
    
    // MARK: Transfers
    
    func selfTransfersPressed() {
        self.performSegue(withIdentifier: OBSegueRouter.toTransfer, sender: nil)
        OBTransferType.transferType = .selfTransfer
    }
    
    
    func phoneTransferPressed() {
        self.performSegue(withIdentifier: OBSegueRouter.toTransfer, sender: nil)
        OBTransferType.transferType = .phoneTransfer
    }
    
    
    func organisationTransferPressed() {
        self.performSegue(withIdentifier: OBSegueRouter.toTransfer, sender: nil)
        OBTransferType.transferType = .organisationTransfer
    }
    
    func emailTransferPressed() {
        self.performSegue(withIdentifier: OBSegueRouter.toTransfer, sender: nil)
        OBTransferType.transferType = .emailTransfer
    }
    
}


extension OBHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBSectionHeaderCell", for: indexPath) as! OBSectionHeaderCell
            cell.titleLabel.text = self.headers[0]
            return cell
        }
        if indexPath.row == cards.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBHomeTransferCell", for: indexPath) as! OBHomeTransferCell
            cell.selfTransferButton.addTarget(self, action:#selector(selfTransfersPressed), for: .touchUpInside)
            cell.phoneTransferButton.addTarget(self, action:#selector(phoneTransferPressed), for: .touchUpInside)
            cell.organisationTransferButton.addTarget(self, action:#selector(organisationTransferPressed), for: .touchUpInside)
            cell.emailTransferButton.addTarget(self, action:#selector(emailTransferPressed), for: .touchUpInside)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBCardCell", for: indexPath) as! OBCardCell
            
            let paymentSystem = cards[indexPath.row - 1].paymentSystem
            cell.icon.image = UIImage.OBImage.getCardImageForType(type: paymentSystem)
            
            if indexPath.row % 2 == 0 {
                cell.cardNumber.text = "**** 5879"
            }
            else {
                cell.cardNumber.text = "**** 7704"
            }
            
            let type = cards[indexPath.row - 1].type
            
            if type == "credit" {
                cell.cardType.text = "Кредитная"
            }
            if type == "debit" {
                cell.cardType.text = "Дебетовая"
            }
            
            return cell
        }
        
    }
    

}

extension OBHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        if indexPath.row == cards.count + 1 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        if indexPath.row == cards.count + 1 {
            return 137
        }
        return 60
    }
    
}
