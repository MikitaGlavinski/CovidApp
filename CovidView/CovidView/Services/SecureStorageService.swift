//
//  SecureStorageService.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/25/21.
//

import Foundation

protocol SecureStorageServiceProtocol {
    func saveLastInfo(countryInfo: InfoCountryModel, currentDate: String)
    func obtainLastInfo() -> InfoCountryModel?
    func saveToken(token: String)
    func obtainToken() -> String?
    func removeToken()
}

class SecureStorageService: SecureStorageServiceProtocol {
    
    static var shared: SecureStorageServiceProtocol = SecureStorageService()
    
    init() {}
    
    let storage = UserDefaults.standard
    
    func saveLastInfo(countryInfo: InfoCountryModel, currentDate: String) {
        var country = countryInfo
        country.date = currentDate
        guard let data = try? JSONEncoder().encode(country) else { return }
        storage.setValue(data, forKey: "countryInfo")
    }
    
    func obtainLastInfo() -> InfoCountryModel? {
        guard
            let data = storage.data(forKey: "countryInfo"),
            let countryInfo = try? JSONDecoder().decode(InfoCountryModel.self, from: data)
        else {
            return nil
        }
        return countryInfo
    }
    
    func saveToken(token: String) {
        storage.setValue(token, forKey: "token")
    }
    
    func obtainToken() -> String? {
        storage.string(forKey: "token")
    }
    
    func removeToken() {
        storage.removeObject(forKey: "token")
    }
}
