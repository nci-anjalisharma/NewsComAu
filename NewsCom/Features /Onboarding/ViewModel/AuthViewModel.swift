//
//  AuthViewModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/06/26.
//

import UIKit
import FirebaseAuth
import Foundation

class AuthViewModel {
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {

            Auth.auth().createUser(withEmail: email, password: password) { result, error in

                if let error {
                    completion(.failure(error))
                    return
                }

                result?.user.sendEmailVerification()

                completion(.success(()))
            }
        }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                return
            }

            completion(.success(user))
        }
    }
    
    func validateEmail(_ email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }
    
    func userFriendlyMessage(for error: Error) -> String {

        let nsError = error as NSError

        guard let code = AuthErrorCode(rawValue: nsError.code) else {
            return error.localizedDescription
        }

        switch code {

        case .emailAlreadyInUse:
            return "This email is already in use."

        case .invalidEmail:
            return "The email address is invalid."

        case .weakPassword:
            return "Password is too weak."

        case .wrongPassword:
            return "Incorrect password."

        case .userNotFound:
            return "No account found."

        case .userDisabled:
            return "This account has been disabled."

        case .networkError:
            return "Network error. Please try again."

        default:
            return error.localizedDescription
        }
    }
    
    func makeAlert(title: String, message: String, actionTitle: String = "OK") -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        return alert
    }
    
    func sendPasswordReset(email: String, completion: @escaping (Result<Void, Error>) -> Void) {

        Auth.auth().sendPasswordReset(withEmail: email) { error in

            if let error {
                completion(.failure(error))
                return
            }

            completion(.success(()))
        }
    }
    
}
