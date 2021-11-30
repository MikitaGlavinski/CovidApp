//
//  InfoViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import UIKit
import MapKit

protocol InfoViewInput: AnyObject {
    func showError(_ error: Error)
    func setCountries(countryModels: [CountryModel])
    func updateInfo(by country: InfoCountryModel)
}

class InfoViewController: UIViewController {
    
    var viewModel: InfoViewModelProtocol!
    private var countryModels = [CountryModel]()
    private var tableViewAppeared = false

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableBackView: StatisticBackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infectedView: StatisticView!
    @IBOutlet weak var deathsView: StatisticView!
    @IBOutlet weak var recoveredView: StatisticView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var doctorViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var statisticBackView: StatisticBackView!
    @IBOutlet weak var textFieldBackView: TextFieldBackView!
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }
    
    private func setupUI() {
        scrollView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.isHidden = true
        
        addGestures()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideTableView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleCountryList))
        textFieldBackView.addGestureRecognizer(textFieldTap)
    }
    
    private func moveCoutryAhead() {
        guard let index = countryModels.firstIndex(where: {$0.name == self.countryLabel.text}) else { return }
        let indexCountry = self.countryModels.remove(at: index)
        self.countryModels.insert(indexCountry, at: 0)
    }

    @IBAction func seeDetailsTapped(_ sender: Any) {
        viewModel.routeToAboutCovidScreen()
    }
    
    @IBAction func dropDownTapped(_ sender: Any) {
        tableBackView.isHidden = false
        tableView.isHidden = false
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    @objc private func hideTableView() {
        tableBackView.isHidden = true
        tableView.isHidden = true
        tableViewAppeared = false
    }
    
    @objc private func handleCountryList() {
        tableBackView.isHidden = false
        tableView.isHidden = false
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}

extension InfoViewController: InfoViewInput {
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func setCountries(countryModels: [CountryModel]) {
        self.countryModels = countryModels
        moveCoutryAhead()
    }
    
    func updateInfo(by country: InfoCountryModel) {
        infectedView.countLabel.text = String(country.confirmed)
        deathsView.countLabel.text = String(country.deaths)
        recoveredView.countLabel.text = String(country.recovered)
//        infectedCountLabel.text = String(country.confirmed)
//        deathsCountLabel.text = String(country.deaths)
//        recoveredCountLabel.text = String(country.recovered)
        countryLabel.text = country.name
        
        updateLabel.text = "Newest update \(country.date)"
        
        mapView.removeAnnotations(mapView.annotations)
        let location = CLLocationCoordinate2D(latitude: country.lat, longitude: country.lon)
        mapView.setCenter(location, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.subtitle = "Infected - \(String(country.confirmed))\nDeaths - \(String(country.deaths))\n Recovered - \(String(country.recovered))"
        mapView.addAnnotation(annotation)
        
        moveCoutryAhead()
    }
}

extension InfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            doctorViewTopConstraint.constant = max(1, (-scrollView.contentOffset.y) * 0.7)
            menuButtonTopConstraint.constant = max(1, (-scrollView.contentOffset.y) * 0.7)
            view.layer.sublayers?[0].frame = CGRect(x: 0,
                                                    y: 0,
                                                    width: UIScreen.main.bounds.width,
                                                    height: max(UIScreen.main.bounds.height / 2, -scrollView.contentOffset.y * 5))
        }
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: countryModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67.5
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < 4 && !tableViewAppeared {
            cell.alpha = 0
            UIView.animate(withDuration: 0.3 * Double(indexPath.row)) {
                cell.alpha = 1
            } completion: { _ in
                self.tableViewAppeared = true
            }
        }
    }
}

extension InfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countryModels[indexPath.row]
        countryLabel.text = country.name
        viewModel.getInfoBy(country: country.slug)
        hideTableView()
    }
}

extension InfoViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tableView) == true {
            return false
        }
        return true
    }
}
