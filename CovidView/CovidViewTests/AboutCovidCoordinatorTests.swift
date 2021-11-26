//
//  AboutCovidCoordinatorTests.swift
//  CovidViewTests
//
//  Created by Mikita Glavinski on 11/26/21.
//

import XCTest
@testable import CovidView

class AboutCovidCoordinatorMock: AboutCovidCoordinator {
    
    private weak var rootNavigationController: UINavigationController?
    
    var childCoordinators = [Coordinator]()
    
    override init(navigation: UINavigationController?) {
        super.init(navigation: navigation)
        self.rootNavigationController = navigation
    }
    
    override func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootNavigationController = rootNavigationController else { return}
        let aboutCovidViewModel = AboutCovidViewModel()
        aboutCovidViewModel.backButtonTapped = {
            self.onEnd()
            self.rootNavigationController?.popViewController(animated: true)
        }
        let aboutCovidView = storyboard.instantiateViewController(withIdentifier: "AboutCovid") as! AboutCovidViewController
        aboutCovidViewModel.view = aboutCovidView
        aboutCovidView.viewModel = aboutCovidViewModel
        
        rootNavigationController.pushViewController(aboutCovidView, animated: true)
    }
    
    override func add(childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    override func remove(childCoordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: {$0 === childCoordinator}) else {
            return
        }
        childCoordinators.remove(at: index)
    }
}

class AboutCovidCoordinatorTests: XCTestCase {
    
    func testStart() {
        let nav = UINavigationController()
        let coordinator = AboutCovidCoordinator(navigation: nav)
        
        XCTAssertEqual(0, nav.viewControllers.count)
        
        coordinator.start()
        
        XCTAssertEqual(1, nav.viewControllers.count)
        XCTAssertTrue(nav.viewControllers[0] is AboutCovidViewController)
    }
    
    func testAdd() {
        let nav = UINavigationController()
        let coordinator = AboutCovidCoordinatorMock(navigation: nav)
        
        coordinator.start()
        
        let secondCoordinator = InfoCoordinator(navigation: nav)
        coordinator.add(childCoordinator: secondCoordinator)
        XCTAssertEqual(1, coordinator.childCoordinators.count)
        XCTAssertTrue(coordinator.childCoordinators[0] is InfoCoordinator)
    }
    
    func testRemove() {
        let nav = UINavigationController()
        let coordinator = AboutCovidCoordinatorMock(navigation: nav)
        
        coordinator.start()
        
        let secondCoordinator = InfoCoordinator(navigation: nav)
        coordinator.add(childCoordinator: secondCoordinator)
        XCTAssertEqual(1, coordinator.childCoordinators.count)
        XCTAssertTrue(coordinator.childCoordinators[0] is InfoCoordinator)
        coordinator.remove(childCoordinator: secondCoordinator)
        XCTAssertEqual(0, coordinator.childCoordinators.count)
    }
}
