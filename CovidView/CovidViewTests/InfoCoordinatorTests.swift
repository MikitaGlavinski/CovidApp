//
//  InfoCoordinatorTests.swift
//  CovidViewTests
//
//  Created by Mikita Glavinski on 11/25/21.
//

import XCTest
@testable import CovidView

class MockInfoCoordinator {
    
    weak var rootNavigationController: UINavigationController?
    
    private var childCoordinators = [Coordinator]()
    
    init(navigation: UINavigationController) {
        self.rootNavigationController = navigation
    }
    
    func start() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoViewModel = InfoViewModel()
        let infoView = storyboard.instantiateViewController(withIdentifier: "Info") as! InfoViewController
        infoViewModel.view = infoView
        infoView.viewModel = infoViewModel
        infoView.loadViewIfNeeded()
        
        rootNavigationController?.pushViewController(infoView, animated: true)
        return infoView
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

class InfoCoordinatorTests: XCTestCase {

    func testStart() {
        let nav = UINavigationController()
        let coordinator = MockInfoCoordinator(navigation: nav)
        
        XCTAssertEqual(0, coordinator.rootNavigationController?.viewControllers.count)
        
        let view = coordinator.start()
        
        XCTAssertTrue(view is InfoViewController)
        XCTAssertEqual(1, coordinator.rootNavigationController?.viewControllers.count)
    }

}
