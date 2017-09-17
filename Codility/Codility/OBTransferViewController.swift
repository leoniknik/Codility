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
import RNCryptor

class OBTransferViewController: UIViewController, EPPickerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: OBBackBarButtonItem!
    
    var contact = ""
    var encodedData: String?
    var accountCell: OBAccountTransferCell?
    var confirmCell: OBTransferConfirmCell?
    
    var accountDictionary: Dictionary<String, String> = [
       "INNTextFieled" : "",
       "accountTextFieled" : "",
       "BIKtextFieled" : "",
       "corpAccountTextFieled" : "",
       "bankNameTextFieled" : "",
       "sumTextFieled" : ""
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupTableView()
        
        if((encodedData) != nil){
            decodeData()
        }
    }
    
    func decodeData() {
        let data = Data(base64Encoded: self.encodedData!)
        do {
            let password = "Secret password"
            let originalData = try RNCryptor.decrypt(data: data!, withPassword: password)
            let parameterDictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: originalData) as? Dictionary<String,Any>
            
                accountDictionary["INNTextFieled"] = parameterDictionary?["INNTextFieled"] as? String
                accountDictionary["accountTextFieled"] = parameterDictionary?["accountTextFieled"] as? String
                accountDictionary["BIKtextFieled"] = parameterDictionary?["BIKtextFieled"] as? String
                accountDictionary["corpAccountTextFieled"] = parameterDictionary?["corpAccountTextFieled"] as? String
                accountDictionary["bankNameTextFieled"] = parameterDictionary?["bankNameTextFieled"] as? String
                accountDictionary["sumTextFieled"] = parameterDictionary?["sumTextFieled"] as? String
            
        } catch {
            print(error)
        }
    }
    
    
    func encode() -> String? {
    
        var parameterDictionary = Dictionary<String, Any>()
        if accountCell != nil && confirmCell != nil {
            parameterDictionary["INNTextFieled"] = accountCell?.INNTextFieled.text
            parameterDictionary["accountTextFieled"] = accountCell?.accountTextFieled.text
            parameterDictionary["BIKtextFieled"] = accountCell?.BIKtextFieled.text
            parameterDictionary["corpAccountTextFieled"] = accountCell?.corpAccountTextFieled.text
            parameterDictionary["bankNameTextFieled"] = accountCell?.bankNameTextFieled.text
            parameterDictionary["sumTextFieled"] = confirmCell?.sumTextField.text
            let data = NSKeyedArchiver.archivedData(withRootObject: parameterDictionary)
            
            let password = "Secret password"
            let ciphertext = RNCryptor.encrypt(data: data, withPassword: password)
            return ciphertext.base64EncodedString()
        }
        
        return nil
        
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
        case .linkTransfer:
            self.navigationItem.title = "Оплатите счет"
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
    
    func createQRCode() {
        
    }
    
    func createLink() {
        if let encodedData = encode() {
            let data = "bank://" + encodedData
            
            let objectsToShare = [data]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.present(activityVC, animated: true, completion: nil)
        }
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
        case .linkTransfer:
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
                self.accountCell = cell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBTransferConfirmCell", for: indexPath) as! OBTransferConfirmCell
                self.confirmCell = cell
                cell.createLinkButton.isHidden = false
                cell.createQRCodeButton.isHidden = false
                cell.createLinkButton.addTarget(self, action: #selector(createLink), for: .touchUpInside)
                cell.createQRCodeButton.addTarget(self, action: #selector(createQRCode), for: .touchUpInside)
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
        case .linkTransfer:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBSimpleTransferCell", for: indexPath) as! OBSimpleTransferCell
                cell.button.setImage(UIImage.OBImage.peopleHome, for: .normal)
                cell.textField.placeholder = "Введите номер карты"
                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBAccountTransferCell", for: indexPath) as! OBAccountTransferCell
                
                cell.INNTextFieled.text = accountDictionary["INNTextFieled"]
                cell.accountTextFieled.text = accountDictionary["accountTextFieled"]
                cell.bankNameTextFieled.text = accountDictionary["bankNameTextFieled"]
                cell.BIKtextFieled.text = accountDictionary["BIKtextFieled"]
                cell.corpAccountTextFieled.text = accountDictionary["corpAccountTextFieled"]
                
                cell.INNTextFieled.isEnabled = false
                cell.accountTextFieled.isEnabled = false
                cell.bankNameTextFieled.isEnabled = false
                cell.BIKtextFieled.isEnabled = false
                cell.corpAccountTextFieled.isEnabled = false
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OBTransferConfirmCell", for: indexPath) as! OBTransferConfirmCell
                cell.createLinkButton.isHidden = true
                cell.createQRCodeButton.isHidden = true
                cell.sumTextField.text = accountDictionary["sumTextFieled"]
                cell.sumTextField.isEnabled = false
                cell.confirmTransferButton.addTarget(self, action: #selector(confirmTransfer), for:.touchUpInside)
                return cell
            }
        }
    }
    
    
    func confirmTransfer() {
        let request = OBCreateInvoiceRequest(rqUID: "", invoiceCreateSum: accountDictionary["sumTextFieled"]!, invoiceCreatePayeeINN: accountDictionary["INNTextFieled"]!, invoiceCreatePayeeAcc: accountDictionary["accountTextFieled"]!, invoiceCreatePayeeBIK: accountDictionary["BIKtextFieled"]!, invoiceCreatePayeeCorrAcc: accountDictionary["corpAccountTextFieled"]!, invoiceCreatePayeeBankname: "Открытие")
        OBAPIManager.createInvoiceRequest(request: request)
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
        case .linkTransfer:
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
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
