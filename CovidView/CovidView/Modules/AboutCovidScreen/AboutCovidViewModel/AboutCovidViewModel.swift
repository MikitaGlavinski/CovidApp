//
//  AboutCovidViewModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/26/21.
//

import Foundation

protocol AboutCovidViewModelProtocol: AnyObject {
    func routeToInfoScreen()
}

class AboutCovidViewModel {
    weak var view: AboutCovidViewInput!
    var coordinator: AboutCovidCoordinatorDelegate!
    
    var backButtonTapped: (() -> ())!
}

extension AboutCovidViewModel: AboutCovidViewModelProtocol {
    
    func routeToInfoScreen() {
        backButtonTapped()
    }
}
