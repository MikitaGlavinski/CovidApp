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
    @IBOutlet weak var buttonConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableBackView: StatisticBackView!
    @IBOutlet weak var tableView: CountriesTableView!
    @IBOutlet weak var infectedCountLabel: UILabel!
    @IBOutlet weak var deathsCountLabel: UILabel!
    @IBOutlet weak var recoveredCountLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    
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
    }

    @IBAction func seeDetailsTapped(_ sender: Any) {
        
    }
    
    @IBAction func dropDownTapped(_ sender: Any) {
        tableBackView.isHidden = false
        tableView.isHidden = false
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    @objc func hideTableView() {
        tableBackView.isHidden = true
        tableView.isHidden = true
        tableViewAppeared = false
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
    }
    
    func updateInfo(by country: InfoCountryModel) {
        infectedCountLabel.text = String(country.confirmed ?? 0)
        deathsCountLabel.text = String(country.deaths ?? 0)
        recoveredCountLabel.text = String(country.recovered ?? 0)
        countryLabel.text = country.name
        
        updateLabel.text = "Newest update \(country.date ?? "")"
        
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        let location = CLLocationCoordinate2D(latitude: country.lat ?? 0.0, longitude: country.lon ?? 0.0)
        mapView.setCenter(location, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.subtitle = "Infected - \(String(country.confirmed ?? 0))\nDeaths - \(String(country.deaths ?? 0))\n Recovered - \(String(country.recovered ?? 0))"
        mapView.addAnnotation(annotation)
    }
}

extension InfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            view.frame.origin.y = max(0, (-scrollView.contentOffset.y) * 1.5)
            view.layer.sublayers?[0].frame = CGRect(x: 0,
                                                    y: 0,
                                                    width: UIScreen.main.bounds.width,
                                                    height: max(UIScreen.main.bounds.height / 2, -scrollView.contentOffset.y * 2.8))
            buttonConstraint.constant = 45 - (-scrollView.contentOffset.y)
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
        viewModel.getInfoBy(country: countryModels[indexPath.row].slug ?? "")
        tableBackView.isHidden = true
        self.tableView.isHidden = true
        let country = countryModels.remove(at: indexPath.row)
        countryModels.insert(country, at: 0)
        tableViewAppeared = false
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
