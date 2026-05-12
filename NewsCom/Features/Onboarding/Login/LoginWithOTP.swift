//
//  LoginWithOTPViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 23/04/26.
//

import UIKit

class LoginWithOTP: UIViewController, UITextFieldDelegate {
    
    //    private var timer: Timer?
    
    
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
        
        //        UserDefaults.standard.set(true, forKey: "hasLoggedIn")
        //        RootNavigationService.shared.showTabBar()
        
        let first = firstTextField.text ?? ""
        let second = secondTextField.text ?? ""
        let third = thirdTextField.text ?? ""
        let fourth = fourthTextField.text ?? ""
        
        
        if first == "1", second == "2", third == "3", fourth == "4" {
            UserDefaults.standard.set(true, forKey: "hasLoggedIn")
            RootNavigationService.shared.showTabBar()
        } else {
            print("Invalid OTP")
        }
        
    }
    
    
    @IBAction func resendCodeTapped(_ sender: Any) {
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//                    if !string.isEmpty {
//                        let textField.text = string
//        
//                        if let nextField = textField + 1 {
//                            nextField.becomeFirstResponder()
//                        } else {
//                            nextField.resignFirstResponder()
//                        }
//        
//        
//                    }
        //
        //
        //
        //            if string.isEmpty {
        //                let textField.text = " "
        //
        //            if let previousField =  textField + 1 {
        //                        previousField.becomeFirstResponder()
        //                    }
        //                    return false
        //                }
        //
        //                return true
        //
        //    }
        //
        //    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //
        //        if textField == firstTextField {
        //
        //            secondTextField.becomeFirstResponder()
        //        } else if textField == secondTextField {
        //                 thirdTextField.becomeFirstResponder()
        //             } else if textField == thirdTextField {
        //
        //                 fourthTextField.becomeFirstResponder()
        //
        //             }
        //
        //
        //            return true
        //        }
        //
        //    }
        
        
        return true
    }
}
