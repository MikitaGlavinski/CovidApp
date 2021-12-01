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
    func facebookSignIn(token: String)
    func appleSignIn(idToken: String, rawNonce: String)
}

class AuthViewModel {
    
    weak var view: AuthViewInput!
    var coordinator: AuthCoordinatorDelegate!
    
    private func signIn(with credential: AuthCredential) {
        AuthorizationService.shared.signIn(with: credential) { result in
            switch result {
            case .success(let token):
                SecureStorageService.shared.saveToken(token: token)
                self.coordinator.routeToInfoScreen()
            case .failure(let error):
                self.view.showError(error)
            }
        }
    }
}

extension AuthViewModel: AuthViewModelProtocol {
    func signInTapped(email: String, password: String) {
        AuthorizationService.shared.signIn(with: email, password: password) { result in
            switch result {
            case .success(let token):
                SecureStorageService.shared.saveToken(token: token)
                self.coordinator.routeToInfoScreen()
            case .failure(let error):
                self.view.showError(error)
            }
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

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            signIn(with: credential)
        }
    }
    
    func createAccount() {
        coordinator.routeToRegister()
    }
    
    func facebookSignIn(token: String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        signIn(with: credential)
    }
    
    func appleSignIn(idToken: String, rawNonce: String) {
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idToken,
                                                  rawNonce: rawNonce)
        signIn(with: credential)
    }
}
