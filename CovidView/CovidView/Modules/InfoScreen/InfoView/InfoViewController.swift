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
        view.addGestureRecognizer(tap)
    }

    @IBAction func seeDetailsTapped(_ sender: Any) {
        print("tap")
    }
    
    @IBAction func dropDownTapped(_ sender: Any) {
        tableBackView.isHidden = false
        tableView.isHidden = false
        tableView.reloadData()
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
        countryLabel.text = countryModels.first?.name
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
    
}
