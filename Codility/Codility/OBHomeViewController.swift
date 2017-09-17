//
//  OBHomeViewController.swift
//  Codility
//
//  Created by Кирилл Володин on 14.09.17.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit
import RealmSwift
import Instructions

class OBHomeViewController: UIViewController, CoachMarksControllerDataSource {
    
    let coachMarksController = CoachMarksController()
    
    var dataSource = Array<[Any]>()
    
    @IBOutlet weak var tableView: UITableView!
    
    let headers = ["Мои карты"]
    
    var cards: Results<OBMyCard> = OBDatabaseManager.getCards()
    
    var isLearn: Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        if !isLearn {
            self.coachMarksController.start(on: self)
            isLearn = true
        }
    }
    
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return dataSource.count
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        //return coachMarksController.helper.makeCoachMark(for: l1)
        return coachMarksController.helper.makeCoachMark(for: dataSource[index][0]as?UIView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        
        coachViews.bodyView.hintLabel.text = dataSource[index][1]as?String
        coachViews.bodyView.nextLabel.text = "Далее"
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(myCardsCallback(_:)), name: .myCardsCallback, object: nil)
        coachMarksController.dataSource = self
    }
    
    func myCardsCallback(_ notification: NSNotification) {
        tableView.reloadData()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "OBCardCell", bundle: nil), forCellReuseIdentifier: "OBCardCell")
        self.tableView.register(UINib(nibName: "OBHomeATMQuestsViewCell", bundle: nil), forCellReuseIdentifier: "OBHomeATMQuestsViewCell")
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
    
    // MARK: footer cell actions
    
    func questsTransferPressed() {
        self.performSegue(withIdentifier: OBSegueRouter.toQuests, sender: nil)
    }
    
    func ATMOutletTransferPressed() {
        self.performSegue(withIdentifier: OBSegueRouter.toATMOutlets, sender: nil)
    }
    
    func QRCodeButtonPressed() {
        self.performSegue(withIdentifier: OBSegueRouter.toQRSCan, sender: nil)
    }
    
}


extension OBHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count + 3
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
            dataSource.append([cell,"Здесь вы можете выполнять основные действия"])
            return cell
        }
        else if indexPath.row == cards.count + 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OBHomeATMQuestsViewCell", for: indexPath) as! OBHomeATMQuestsViewCell
            
            cell.questsButton.addTarget(self, action:#selector(questsTransferPressed), for: .touchUpInside)
            cell.ATMOutletButton.addTarget(self, action:#selector(ATMOutletTransferPressed), for: .touchUpInside)
            cell.QRCodeButton.addTarget(self, action:#selector(QRCodeButtonPressed), for: .touchUpInside)
            dataSource.append([cell,"Здесь вы можете выполнять дополнительные действия"])
            return cell
        }
        else{
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
            dataSource.append([cell,"Это ваша карта"])
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
        if indexPath.row >= cards.count + 1 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        if indexPath.row >= cards.count + 1 {
            return 137
        }
        return 60
    }
    
}
