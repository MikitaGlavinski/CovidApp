//
//  AboutCovidCoordinator.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/26/21.
//

import UIKit

protocol AboutCovidCoordinatorDelegate {
    
}

class AboutCovidCoordinator: Coordinator {
    
    private weak var rootNavigationController: UINavigationController?
    var onEnd: (() -> ())!
    
    private var childCoordinators = [Coordinator]()
    
    init(navigation: UINavigationController?) {
        self.rootNavigationController = navigation
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootNavigationController = rootNavigationController else { return}
        let aboutCovidViewModel = AboutCovidViewModel()
        aboutCovidViewModel.backButtonTapped = {
            self.onEnd()
            self.rootNavigationController?.popViewController(animated: true)
        }
        let aboutCovidView = storyboard.instantiateViewController(withIdentifier: "AboutCovid") as! AboutCovidViewController
        aboutCovidViewModel.view = aboutCovidView
        aboutCovidViewModel.coordinator = self
        aboutCovidView.viewModel = aboutCovidViewModel
        
        rootNavigationController.pushViewController(aboutCovidView, animated: true)
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

extension AboutCovidCoordinator: AboutCovidCoordinatorDelegate {
    
}
