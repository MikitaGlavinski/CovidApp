//
//  InfoCoordinator.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import UIKit

protocol InfoCoordinatorDelegate: AnyObject {
    func routeToAboutCovidScreen()
}

class InfoCoordinator: Coordinator {
    
    private weak var rootNavigationController: UINavigationController?
    
    private var childCoordinators = [Coordinator]()
    
    init(navigation: UINavigationController) {
        self.rootNavigationController = navigation
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootNavigationController = rootNavigationController else { return}
        let infoViewModel = InfoViewModel()
        let infoView = storyboard.instantiateViewController(withIdentifier: "Info") as! InfoViewController
        infoViewModel.view = infoView
        infoViewModel.coordinator = self
        infoView.viewModel = infoViewModel
        
        rootNavigationController.setViewControllers([infoView], animated: true)
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
    
    func routeToAboutCovidScreen() {
        let aboutCovidCoordinator = AboutCovidCoordinator(navigation: rootNavigationController)
        aboutCovidCoordinator.onEnd = { [unowned aboutCovidCoordinator] in
            self.remove(childCoordinator: aboutCovidCoordinator)
        }
        aboutCovidCoordinator.start()
        add(childCoordinator: aboutCovidCoordinator)
    }
}
