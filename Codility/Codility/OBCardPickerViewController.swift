//
//  OBCardPickerViewController.swift
//  Codility
//
//  Created by Кирилл Володин on 17.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit
import RealmSwift

class OBCardPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cards: Results<OBMyCard> = OBDatabaseManager.getCards()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "OBCardCell", bundle: nil), forCellReuseIdentifier: "OBCardCell")
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OBCardPickerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OBCardCell", for: indexPath) as! OBCardCell
        
        let paymentSystem = cards[indexPath.row].paymentSystem
        cell.icon.image = UIImage.OBImage.getCardImageForType(type: paymentSystem)
        
        if indexPath.row % 2 == 0 {
            cell.cardNumber.text = "**** 5879"
        }
        else {
            cell.cardNumber.text = "**** 7704"
        }
        
        let type = cards[indexPath.row].type
        
        if type == "credit" {
            cell.cardType.text = "Кредитная"
        }
        if type == "debit" {
            cell.cardType.text = "Дебетовая"
        }
        
        return cell
    }


}

extension OBCardPickerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let count = self.navigationController?.viewControllers.count
        let viewController = self.navigationController?.viewControllers[count! - 2] as! OBTransferViewController
        let cell = tableView.cellForRow(at: indexPath) as! OBCardCell
        if viewController.isForSecond {
            viewController.simpleCellTo?.textField.text = cell.cardNumber.text
        } else {
            viewController.simpleCellFrom?.textField.text = cell.cardNumber.text
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

