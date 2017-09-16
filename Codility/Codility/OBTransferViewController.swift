//
//  OBTransferViewController.swift
//  Codility
//
//  Created by Кирилл Володин on 16.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

//клава

import UIKit
import ContactsUI
import EPContactsPicker

class OBTransferViewController: UIViewController, EPPickerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: OBBackBarButtonItem!
    var contact = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupTableView()
    }

    func setupHeader() {
        switch OBTransferType.transferType {
        case .selfTransfer:
            self.navigationItem.title = "Между своими счетами"
        case .phoneTransfer:
            self.navigationItem.title = "По номеру телефона"
        case .organisationTransfer:
            self.navigationItem.title = "Перевод на счет"
        case .emailTransfer:
            self.navigationItem.title = "Перевод по E-mail"
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
    
    func chooseContact() {
        var value = SubtitleCellValue.phoneNumber
        if OBTransferType.transferType == .emailTransfer {
            value = SubtitleCellValue.email
        }
        let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:false, subtitleCellType: value)
        let navigationController = UINavigationController(rootViewController: contactPickerScene)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func epContactPicker(_: EPContactsPicker, didCancel error : NSError) {
        print("error choosing contact")
    }
    
    func epContactPicker(_: EPContactsPicker, didSelectContact contact : EPContact) {
        if OBTransferType.transferType == .phoneTransfer {
            if !contact.phoneNumbers.isEmpty {
                self.contact = contact.phoneNumbers[0].phoneNumber
            }
        }
        else {
            if !contact.emails.isEmpty {
                self.contact = contact.emails[0].email
            }
        }
        tableView.reloadData()
    }
    
}


extension OBTransferViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch OBTransferType.transferType {
        case .selfTransfer:
            return 3
        case .phoneTransfer:
            return 3
        case .organisationTransfer:
            return 2
        case .emailTransfer:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch OBTransferType.transferType {
        case .selfTransfer:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBSimpleTransferCell", for: indexPath) as! OBSimpleTransferCell
                cell.button.setImage(UIImage.OBImage.peopleHome, for: .normal)
                cell.textField.placeholder = "Введите номер карты"
                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBSimpleTransferCell", for: indexPath) as! OBSimpleTransferCell
                cell.button.setImage(UIImage.OBImage.peopleHome, for: .normal)
                cell.titleLabel.text = "Куда перевести"
                cell.textField.placeholder = "Введите номер карты"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBTransferConfirmCell", for: indexPath) as! OBTransferConfirmCell
                return cell
            }
        case .phoneTransfer:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBSimpleTransferCell", for: indexPath) as! OBSimpleTransferCell
                cell.button.setImage(UIImage.OBImage.peopleHome, for: .normal)
                cell.textField.placeholder = "Введите номер карты"
                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBSimpleTransferCell", for: indexPath) as! OBSimpleTransferCell
                cell.button.setImage(UIImage.OBImage.phoneHome, for: .normal)
                cell.button.addTarget(self, action: #selector(chooseContact), for: .touchUpInside)
                cell.titleLabel.text = "Куда перевести"
                cell.textField.text = contact
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBTransferConfirmCell", for: indexPath) as! OBTransferConfirmCell
                return cell
            }
        case .organisationTransfer:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBAccountTransferCell", for: indexPath) as! OBAccountTransferCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBTransferConfirmCell", for: indexPath) as! OBTransferConfirmCell
                return cell
            }
        case .emailTransfer:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBSimpleTransferCell", for: indexPath) as! OBSimpleTransferCell
                cell.button.setImage(UIImage.OBImage.peopleHome, for: .normal)
                cell.textField.placeholder = "Введите номер карты"
                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBSimpleTransferCell", for: indexPath) as! OBSimpleTransferCell
                cell.button.setImage(UIImage.OBImage.emailHome, for: .normal)
                cell.button.addTarget(self, action: #selector(chooseContact), for: .touchUpInside)
                cell.titleLabel.text = "Куда перевести"
                cell.textField.placeholder = "Введите e-mail"
                cell.textField.text = contact
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBTransferConfirmCell", for: indexPath) as! OBTransferConfirmCell
                return cell
            }
        }

    }
    
    
}

extension OBTransferViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return getHeightForCurrentTransferType(indexPath)
        
    }
    
    func getHeightForCurrentTransferType(_ indexPath: IndexPath) -> CGFloat {
        switch OBTransferType.transferType {
        case .selfTransfer:
            if indexPath.row == 0 {
                return 77
            }
            else if indexPath.row == 1 {
                return 77
            } else {
                return 148
            }
        case .phoneTransfer:
            if indexPath.row == 0 {
                return 77
            }
            else if indexPath.row == 1 {
                return 77
            } else {
                return 148
            }
        case .organisationTransfer:
            if indexPath.row == 0 {
                return 246
            } else {
                return 148
            }
        case .emailTransfer:
            if indexPath.row == 0 {
                return 77
            }
            else if indexPath.row == 1 {
                return 77
            } else {
                return 148
            }
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
