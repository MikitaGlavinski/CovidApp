//
//  AuthViewModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/29/21.
//

import UIKit
import GoogleSignIn
import Firebase

protocol AuthViewModelProtocol {
    func signInTapped(email: String, password: String)
    func googleTapped()
    func createAccount()
}

class AuthViewModel {
    
    weak var view: AuthViewInput!
    var coordinator: AuthCoordinatorDelegate!
    
}

extension AuthViewModel: AuthViewModelProtocol {
    func signInTapped(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.view.showError(error)
                return
            }
            guard let token = authResult?.user.uid else { return }
            SecureStorageService.shared.saveToken(token: token)
            self.coordinator.routeToInfoScreen()
        }
    }
    
    func googleTapped() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(with: config, presenting: view as! UIViewController) { [unowned self] user, error in

          if let error = error {
              self.view.showError(error)
              return
          }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.view.showError(error)
                    return
                }
                guard let token = authResult?.user.uid else { return }
                SecureStorageService.shared.saveToken(token: token)
                self.coordinator.routeToInfoScreen()
            }
        }
    }
    
    func createAccount() {
        coordinator.routeToRegister()
    }
}
