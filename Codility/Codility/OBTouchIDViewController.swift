//
//  TouchIDViewController.swift
//  Codility
//
//  Created by Aleksander Evtuhov on 16/09/2017.
//  Copyright © 2017 Кирилл Володин. All rights reserved.
//

import UIKit
import LocalAuthentication

class OBTouchIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
    
        let authenticationContext = LAContext()
        var error: NSError?
        
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }

        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Авторизуйтесь!",
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {

                    DispatchQueue.main.async {
                        self.navigateToAuthenticatedViewController()
                    }
                    
                }else {
                    
                    if let error = error {
                        self.showAlertViewAfterEvaluatingPolicyWithMessage(error.localizedDescription)
                    }
                    
                }
                
        })
        
    }
    
    
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle("Error", message: "This device does not have a TouchID sensor.")
        
    }
    
    
    func showAlertViewAfterEvaluatingPolicyWithMessage( _ message:String ){
        
        showAlertWithTitle("Error", message: message)
        
    }
    
    
    func showAlertWithTitle( _ title:String, message:String ) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async { () -> Void in
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
        
    }
    
    
    func navigateToAuthenticatedViewController(){
        //showAlertWithTitle("ok", message: "sucsess autentification")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateInitialViewController()
        self.present(nextViewController!, animated:true, completion:nil)
    }
}
