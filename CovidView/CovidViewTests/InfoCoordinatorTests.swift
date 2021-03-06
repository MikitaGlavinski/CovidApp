//
//  InfoCoordinatorTests.swift
//  CovidViewTests
//
//  Created by Mikita Glavinski on 11/25/21.
//

import XCTest
@testable import CovidView

class InfoCoordinatorMock: InfoCoordinator {
    
    private weak var rootNavigationController: UINavigationController?
    
    var childCoordinators = [Coordinator]()
    
    override init(navigation: UINavigationController) {
        super.init(navigation: navigation)
        self.rootNavigationController = navigation
    }
    
    override func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootNavigationController = rootNavigationController else { return}
        let infoViewModel = InfoViewModel()
        let infoView = storyboard.instantiateViewController(withIdentifier: "Info") as! InfoViewController
        infoViewModel.view = infoView
        infoViewModel.coordinator = self
        infoView.viewModel = infoViewModel
        
        rootNavigationController.pushViewController(infoView, animated: true)
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

class InfoCoordinatorTests: XCTestCase {

    func testStart() {
        let nav = UINavigationController()
        let coordinator = InfoCoordinatorMock(navigation: nav)
        
        XCTAssertEqual(0, nav.viewControllers.count)
        
        coordinator.start()
        
        XCTAssertEqual(1, nav.viewControllers.count)
        XCTAssertTrue(nav.viewControllers[0] is InfoViewController)
    }
    
    func testRouteToAboutCovid() {
        
        let nav = UINavigationController()
        let coordinator = InfoCoordinator(navigation: nav)
        
        coordinator.start()
        coordinator.routeToAboutCovidScreen()
        
        XCTAssertEqual(1, nav.viewControllers.count)
        XCTAssertTrue(nav.viewControllers[0] is InfoViewController)
    }
    
    func testAdd() {
        let nav = UINavigationController()
        let coordinator = InfoCoordinatorMock(navigation: nav)
        
        coordinator.start()
        
        let secondCoordinator = AboutCovidCoordinator(navigation: nav)
        coordinator.add(childCoordinator: secondCoordinator)
        XCTAssertEqual(1, coordinator.childCoordinators.count)
        XCTAssertTrue(coordinator.childCoordinators[0] is AboutCovidCoordinator)
    }
    
    func testRemove() {
        let nav = UINavigationController()
        let coordinator = InfoCoordinatorMock(navigation: nav)
        
        coordinator.start()
        
        let secondCoordinator = AboutCovidCoordinator(navigation: nav)
        coordinator.add(childCoordinator: secondCoordinator)
        XCTAssertEqual(1, coordinator.childCoordinators.count)
        XCTAssertTrue(coordinator.childCoordinators[0] is AboutCovidCoordinator)
        coordinator.remove(childCoordinator: secondCoordinator)
        XCTAssertEqual(0, coordinator.childCoordinators.count)
    }
}
