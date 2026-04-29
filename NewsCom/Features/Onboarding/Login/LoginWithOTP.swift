//
//  LoginWithOTPViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 23/04/26.
//

import UIKit

class LoginWithOTP: UIViewController, UITextFieldDelegate {
    
    private var timer: Timer?
    
    
    @IBOutlet weak var otpPlaceholder: UIStackView!
    
    
    @IBOutlet weak var firstTextField: UITextField!
    
    
    @IBOutlet weak var secondTextField: UITextField!
    
    
    @IBOutlet weak var thirdTextField: UITextField!
    
    
    
    @IBOutlet weak var fourthTextField: UITextField!
    
    
    
    
    
    @IBOutlet weak var verifyAndContinueButton: UIButton!
    
    
    
    
    @IBOutlet weak var resendCodeButton: UIButton!
     
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    @IBAction func verifyAndContinueTapped(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "hasLoggedIn")
        RootNavigationService.shared.showTabBar()
        
    }
    
    
    @IBAction func resendCodeTapped(_ sender: Any) {
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        
        
        return false
    }
}


