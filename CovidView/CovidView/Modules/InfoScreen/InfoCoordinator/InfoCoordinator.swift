//
//  InfoCoordinator.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import UIKit

protocol InfoCoordinatorDelegate: AnyObject {
    
}

class InfoCoordinator: Coordinator {
    
    private weak var rootNavigationController: UINavigationController?
    
    private var childCoordinators = [Coordinator]()
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    func start() {
        guard let rootNavigationController = rootNavigationController else { return }
        let infoViewModel = InfoViewModel()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoView = storyboard.instantiateViewController(withIdentifier: "Info") as! InfoViewController
//        let infoView = InfoViewController()
        infoViewModel.view = infoView
        infoViewModel.coordinator = self
        infoView.viewModel = infoViewModel
        
        rootNavigationController.pushViewController(infoView, animated: true)
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

extension InfoCoordinator: InfoCoordinatorDelegate {
    
}
