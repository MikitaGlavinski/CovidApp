//
//  InfoViewControllerTests.swift
//  CovidViewTests
//
//  Created by Mikita Glavinski on 11/25/21.
//

import XCTest
@testable import CovidView

class InfoViewControllerTests: XCTestCase {

    func testUpdate() {
        let countryModel = InfoCountryModel(id: "id", name: "name", code: "code", province: "province", city: "city", cityCode: "cityCode", lat: 20.0, lon: 30.0, confirmed: 1, deaths: 2, recovered: 3, active: 4, date: "date")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoView = storyboard.instantiateViewController(withIdentifier: "Info") as! InfoViewController
        let viewModel = InfoViewModel()
        viewModel.view = infoView
        infoView.viewModel = viewModel
        infoView.loadViewIfNeeded()
        infoView.updateInfo(by: countryModel)
        
        XCTAssertEqual(countryModel.name, infoView.countryLabel.text, "Filed to update InfoViewController")
        XCTAssertEqual(String(countryModel.confirmed!), infoView.infectedCountLabel.text, "Filed to update InfoViewController")
        XCTAssertEqual(String(countryModel.deaths!), infoView.deathsCountLabel.text, "Filed to update InfoViewController")
        XCTAssertEqual(String(countryModel.recovered!), infoView.recoveredCountLabel.text, "Filed to update InfoViewController")
        XCTAssertEqual("Newest update \(countryModel.date!)", infoView.updateLabel.text, "Filed to update InfoViewController")
    }
    
    func testSetupUI() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoView = storyboard.instantiateViewController(withIdentifier: "Info") as! InfoViewController
        let viewModel = InfoViewModel()
        viewModel.view = infoView
        infoView.viewModel = viewModel
        infoView.loadViewIfNeeded()
        
        XCTAssertNotNil(viewModel.view)
        XCTAssertNotNil(infoView.viewModel)
        XCTAssertNotNil(infoView.tableView.dataSource)
        XCTAssertNotNil(infoView.tableView.delegate)
        XCTAssertNotNil(infoView.scrollView.delegate)
    }
}
