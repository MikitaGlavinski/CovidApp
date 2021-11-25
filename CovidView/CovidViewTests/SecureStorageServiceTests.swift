//
//  SecureStorageServiceTests.swift
//  CovidViewTests
//
//  Created by Mikita Glavinski on 11/25/21.
//

import XCTest
@testable import CovidView

class SecureStorageServiceTests: XCTestCase {

    func testSaveLastInfo() {
        let name = "name"
        let confirmed = 100
        let deaths = 50
        let recovered = 30
        let lat = 20.0
        let lon = 15.0
        let date = "date"
        let testModel = InfoCountryModel(name: name, lat: lat, lon: lon, confirmed: confirmed, deaths: deaths, recovered: recovered)
        SecureStorageService.shared.saveLastInfo(countryInfo: testModel, currentDate: date)
        
        XCTAssertEqual(name, UserDefaults.standard.string(forKey: "country"), "test save info failed")
        XCTAssertEqual(confirmed, UserDefaults.standard.integer(forKey: "confirmed"), "test save info failed")
        XCTAssertEqual(deaths, UserDefaults.standard.integer(forKey: "deaths"), "test save info failed")
        XCTAssertEqual(recovered, UserDefaults.standard.integer(forKey: "recovered"), "test save info failed")
        XCTAssertEqual(lat, UserDefaults.standard.double(forKey: "lat"), "test save info failed")
        XCTAssertEqual(lon, UserDefaults.standard.double(forKey: "lon"), "test save info failed")
        XCTAssertEqual(date, UserDefaults.standard.string(forKey: "date"), "test save info failed")
        
        UserDefaults.standard.removeObject(forKey: "country")
        UserDefaults.standard.removeObject(forKey: "confirmed")
        UserDefaults.standard.removeObject(forKey: "deaths")
        UserDefaults.standard.removeObject(forKey: "recovered")
        UserDefaults.standard.removeObject(forKey: "lat")
        UserDefaults.standard.removeObject(forKey: "lon")
        UserDefaults.standard.removeObject(forKey: "date")
    }
    
    func testObtainLastInfo() {
        let name = "name"
        let confirmed = 100
        let deaths = 50
        let recovered = 30
        let lat = 20.0
        let lon = 15.0
        let date = "date"
        
        UserDefaults.standard.setValue(name, forKey: "country")
        UserDefaults.standard.setValue(confirmed, forKey: "confirmed")
        UserDefaults.standard.setValue(deaths, forKey: "deaths")
        UserDefaults.standard.setValue(recovered, forKey: "recovered")
        UserDefaults.standard.setValue(lat, forKey: "lat")
        UserDefaults.standard.setValue(lon, forKey: "lon")
        UserDefaults.standard.setValue(date, forKey: "date")
        
        let lastInfo = SecureStorageService.shared.obtainLastInfo()
        
        XCTAssertEqual(name, lastInfo.name, "test obtain info failed")
        XCTAssertEqual(confirmed, lastInfo.confirmed, "test obtain info failed")
        XCTAssertEqual(deaths, lastInfo.deaths, "test obtain info failed")
        XCTAssertEqual(recovered, lastInfo.recovered, "test obtain info failed")
        XCTAssertEqual(lat, lastInfo.lat, "test obtain info failed")
        XCTAssertEqual(lon, lastInfo.lon, "test obtain info failed")
        XCTAssertEqual(date, lastInfo.date, "test obtain info failed")
        
        UserDefaults.standard.removeObject(forKey: "country")
        UserDefaults.standard.removeObject(forKey: "confirmed")
        UserDefaults.standard.removeObject(forKey: "deaths")
        UserDefaults.standard.removeObject(forKey: "recovered")
        UserDefaults.standard.removeObject(forKey: "lat")
        UserDefaults.standard.removeObject(forKey: "lon")
        UserDefaults.standard.removeObject(forKey: "date")
    }

}
