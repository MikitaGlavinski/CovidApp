//
//  InfoViewModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import Foundation

protocol InfoViewModelProtocol: AnyObject {
    func viewDidLoad()
}

class InfoViewModel {
    weak var coordinator: InfoCoordinatorDelegate!
    weak var view: InfoViewInput!
}

extension InfoViewModel: InfoViewModelProtocol {
    
    func viewDidLoad() {
        NetworkService.shared.getAllCountries { result in
            switch result {
            case .success(let countries):
                DispatchQueue.main.async {
                    self.view.setCountries(countryModels: countries)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.showError(error)
                }
            }
        }
    }
}
