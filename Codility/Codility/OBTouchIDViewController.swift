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
        if(true){
            navigateToAuthenticatedViewController()
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
        // 1. Create a authentication context
        let authenticationContext = LAContext()
        var error:NSError?
        
        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }
        
        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Авторизуйтесь!",
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    
                    // Fingerprint recognized
                    // Go to view controller
                    self.navigateToAuthenticatedViewController()
                    
                }else {
                    
                    // Check if there is an error
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.present(controller!, animated: true, completion: nil)
    }
}
