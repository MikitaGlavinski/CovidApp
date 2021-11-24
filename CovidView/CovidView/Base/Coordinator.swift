//
//  Coordinator.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/23/21.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func add(childCoordinator: Coordinator)
    func remove(childCoordinator: Coordinator)
}
