//
//  RegisterViewModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/29/21.
//

import Foundation
import Firebase

protocol RegisterViewModelProtocol: AnyObject {
    func createAccount(with email: String, password: String)
    func viewDissapeared()
}

class RegisterViewModel {
    
    weak var view: RegisterViewInput!
    var coordinator: RegisterCoordinatorDelegate!
    var backButtonTapped: (() -> ())!
}

extension RegisterViewModel: RegisterViewModelProtocol {
    
    func createAccount(with email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.view.showError(error)
                return
            }
            guard let token = authResult?.user.uid else { return }
            SecureStorageService.shared.saveToken(token: token)
            self.coordinator.routeToInfoScreen()
        }
    }
    
    func viewDissapeared() {
        backButtonTapped()
    }
}
