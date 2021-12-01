//
//  AuthCoordinator.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/29/21.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func routeToInfoScreen()
    func routeToRegister()
}

class AuthCoordinator: Coordinator {
    
    private weak var rootNavigationController: UINavigationController?
    
    private var childCoordinators = [Coordinator]()
    
    init(navigation: UINavigationController) {
        self.rootNavigationController = navigation
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootNavigationController = rootNavigationController else { return}
        let authViewModel = AuthViewModel()
        let authView = storyboard.instantiateViewController(withIdentifier: "Auth") as! AuthViewController
        authViewModel.view = authView
        authViewModel.coordinator = self
        authView.viewModel = authViewModel
        
        rootNavigationController.setViewControllers([authView], animated: false)
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

extension AuthCoordinator: AuthCoordinatorDelegate {
    
    func routeToInfoScreen() {
        guard let rootNavigationController = rootNavigationController else { return }
        let infoCoordinator = InfoCoordinator(navigation: rootNavigationController)
        infoCoordinator.start()
    }
    
    func routeToRegister() {
        guard let rootNavigationController = rootNavigationController else { return }
        let registerCoordinator = RegisterCoordinator(navigation: rootNavigationController)
        registerCoordinator.onEnd = { [unowned registerCoordinator] in
            self.remove(childCoordinator: registerCoordinator)
        }
        registerCoordinator.start()
        add(childCoordinator: registerCoordinator)
    }
}
