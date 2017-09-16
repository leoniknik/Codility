//
//  OBTransferViewController.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit

class OBTransferViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: OBBackBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupTableView()
    }

    func setupHeader() {
        switch OBTransferType.transferType {
        case .selfTransfer:
            self.navigationItem.title = "Перевод между своими счетами"
        case .phoneTransfer:
            self.navigationItem.title = "Перевод по номеру телефона"
        case .organisationTransfer:
            self.navigationItem.title = "Перевод на счет"
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "OBSimpleTransferCell", bundle: nil), forCellReuseIdentifier: "OBSimpleTransferCell")
        self.tableView.register(UINib(nibName: "OBAccountTransferCell", bundle: nil), forCellReuseIdentifier: "OBAccountTransferCell")
        self.tableView.register(UINib(nibName: "OBTransferConfirmCell", bundle: nil), forCellReuseIdentifier: "OBTransferConfirmCell")
        
    }
    
    @IBAction func goBack(_ sender: OBBackBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension OBTransferViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // заглушка
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBSimpleTransferCell", for: indexPath) as! OBSimpleTransferCell
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBAccountTransferCell", for: indexPath) as! OBAccountTransferCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBTransferConfirmCell", for: indexPath) as! OBTransferConfirmCell
//            cell.selfTransferButton.addTarget(self, action:#selector(selfTransfersPressed), for: .touchUpInside)
//            cell.phoneTransferButton.addTarget(self, action:#selector(phoneTransferPressed), for: .touchUpInside)
//            cell.organisationTransferButton.addTarget(self, action:#selector(organisationTransferPressed), for: .touchUpInside)
            return cell
        }
    }
    
    
}

extension OBTransferViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 77
        }
        else if indexPath.row == 1 {
            return 246
        } else {
            return 148
        }
        
    }
    
}
