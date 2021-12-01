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
        AuthorizationService.shared.createAccount(with: email, password: password) { result in
            switch result {
            case .success(let token):
                SecureStorageService.shared.saveToken(token: token)
                self.coordinator.routeToInfoScreen()
            case .failure(let error):
                self.view.showError(error)
            }
        }
    }
    
    func viewDissapeared() {
        backButtonTapped()
    }
}
