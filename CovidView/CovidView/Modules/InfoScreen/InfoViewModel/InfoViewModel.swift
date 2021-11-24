//
//  InfoViewModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import Foundation

protocol InfoViewModelProtocol: AnyObject {
    
}

class InfoViewModel {
    weak var coordinator: InfoCoordinatorDelegate!
    weak var view: InfoViewInput!
}

extension InfoViewModel: InfoViewModelProtocol {
    
}
