//
//  InfoViewModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import Foundation

protocol InfoViewModelProtocol: AnyObject {
    func viewDidLoad()
    func getInfoBy(country: String)
}

class InfoViewModel {
    var coordinator: InfoCoordinatorDelegate!
    weak var view: InfoViewInput!
}

extension InfoViewModel: InfoViewModelProtocol {
    
    func viewDidLoad() {
        let lastInfo = SecureStorageService.shared.obtainLastInfo()
        view.updateInfo(by: lastInfo)
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
    
    func getInfoBy(country: String) {
        NetworkService.shared.getInfoBy(country: country) { result in
            switch result {
            case .success(let infoCountryModels):
                guard var country = infoCountryModels.last else { return }
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM dd"
                let stringDate = formatter.string(from: date)
                SecureStorageService.shared.saveLastInfo(countryInfo: country, currentDate: stringDate)
                country.date = stringDate
                DispatchQueue.main.async {
                    self.view.updateInfo(by: country)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.showError(error)
                }
            }
        }
    }
}
