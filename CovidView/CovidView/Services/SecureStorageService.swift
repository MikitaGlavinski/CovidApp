//
//  SecureStorageService.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/25/21.
//

import Foundation

protocol SecureStorageServiceProtocol {
    func saveLastInfo(countryInfo: InfoCountryModel, currentDate: String)
    func obtainLastInfo() -> InfoCountryModel
}

class SecureStorageService: SecureStorageServiceProtocol {
    
    static var shared: SecureStorageServiceProtocol = SecureStorageService()
    
    init() {}
    
    let storage = UserDefaults.standard
    
    func saveLastInfo(countryInfo: InfoCountryModel, currentDate: String) {
        storage.setValue(countryInfo.name, forKey: "country")
        storage.setValue(countryInfo.confirmed, forKey: "confirmed")
        storage.setValue(countryInfo.deaths, forKey: "deaths")
        storage.setValue(countryInfo.recovered, forKey: "recovered")
        storage.setValue(countryInfo.lat, forKey: "lat")
        storage.setValue(countryInfo.lon, forKey: "lon")
        storage.setValue(currentDate, forKey: "date")
    }
    
    func obtainLastInfo() -> InfoCountryModel {
        InfoCountryModel(name: storage.string(forKey: "country"),
                         lat: storage.double(forKey: "lat"),
                         lon: storage.double(forKey: "lon"),
                         confirmed: storage.integer(forKey: "confirmed"),
                         deaths: storage.integer(forKey: "deaths"),
                         recovered: storage.integer(forKey: "recovered"),
                         date: storage.string(forKey: "date"))
    }
}
