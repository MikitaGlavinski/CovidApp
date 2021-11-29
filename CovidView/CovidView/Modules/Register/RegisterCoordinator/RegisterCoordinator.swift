//
//  RegisterCoordinator.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/29/21.
//

import UIKit

protocol RegisterCoordinatorDelegate {
    func routeToInfoScreen()
}

class RegisterCoordinator: Coordinator {
    
    private weak var rootNavigationController: UINavigationController?
    
    private var childCoordinators = [Coordinator]()
    var onEnd: (() -> ())!
    
    init(navigation: UINavigationController) {
        self.rootNavigationController = navigation
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootNavigationController = rootNavigationController else { return}
        let registerViewModel = RegisterViewModel()
        registerViewModel.backButtonTapped = {
            self.onEnd()
            self.rootNavigationController?.popViewController(animated: true)
        }
        let registerView = storyboard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        registerViewModel.view = registerView
        registerViewModel.coordinator = self
        registerView.viewModel = registerViewModel
        
        rootNavigationController.pushViewController(registerView, animated: true)
    }
    
    func add(childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    func remove(childCoordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: {$0 === childCoordinator}) else {
            return
        }
        childCoordinators.remove(at: index)
    }
    
    
}

extension RegisterCoordinator: RegisterCoordinatorDelegate {
    
    func routeToInfoScreen() {
        guard let rootNavigationController = rootNavigationController else { return}
        let info = InfoCoordinator(navigation: rootNavigationController)
        info.start()
    }
}
