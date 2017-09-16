//
//  OBHomeViewController.swift
//  Codility
//
//  Created by Кирилл Володин on 14.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit
import SwiftyJSON

class OBHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let headers = ["Мои карты"]
    
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
    
    
    // MARK: IBActions
    
    @IBAction func goBack(_ sender: OBBackBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension OBHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // заглушка
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBSectionHeaderCell", for: indexPath) as! OBSectionHeaderCell
            cell.titleLabel.text = self.headers[0]
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBHomeTransferCell", for: indexPath) as! OBHomeTransferCell
            cell.selfTransferButton.addTarget(self, action:#selector(selfTransfersPressed), for: .touchUpInside)
            cell.phoneTransferButton.addTarget(self, action:#selector(phoneTransferPressed), for: .touchUpInside)
            cell.organisationTransferButton.addTarget(self, action:#selector(organisationTransferPressed), for: .touchUpInside)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBCardCell", for: indexPath) as! OBCardCell
            cell.icon.image = UIImage.OBImage.visa
            return cell
        }
        
    }
    

}

extension OBHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        if indexPath.row == 4 {
            return 124
        }
        return 60
    }
    
}
