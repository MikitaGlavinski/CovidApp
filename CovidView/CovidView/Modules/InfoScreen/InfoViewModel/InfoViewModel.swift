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
    weak var coordinator: InfoCoordinatorDelegate!
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
        let date = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 86400)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        NetworkService.shared.getInfoBy(country: country, date: formatter.string(from: date)) { result in
            switch result {
            case .success(let infoCountryModels):
                guard var country = infoCountryModels.last else { return }
                let date = Date()
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
