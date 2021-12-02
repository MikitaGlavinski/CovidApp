//
//  AboutCovidViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/26/21.
//

import UIKit

protocol AboutCovidViewInput: AnyObject {
    
}

class AboutCovidViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doctorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var wearMaskView: PreventionBackView!
    @IBOutlet weak var washHandsView: PreventionBackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var headacheView: SymptomView!
    @IBOutlet weak var coughView: SymptomView!
    @IBOutlet weak var feverView: SymptomView!
    
    var viewModel: AboutCovidViewModelProtocol!
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.routeToInfoScreen()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        scrollView.delegate = self
        
        headacheView.text = String(localized: "Headache")
        coughView.text = String(localized: "Cough")
        feverView.text = String(localized: "Fever")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        viewModel.routeToInfoScreen()
    }
    
}

extension AboutCovidViewController: AboutCovidViewInput {
    
}

extension AboutCovidViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            doctorTopConstraint.constant = max(1, (-scrollView.contentOffset.y) * 0.7)
            menuButtonTopConstraint.constant = max(1, (-scrollView.contentOffset.y) * 0.7)
            backButtonTopConstraint.constant = max(1, (-scrollView.contentOffset.y) * 0.7)
            view.layer.sublayers?[0].frame = CGRect(x: 0,
                                                    y: 0,
                                                    width: UIScreen.main.bounds.width,
                                                    height: max(UIScreen.main.bounds.height / 2, -scrollView.contentOffset.y * 20))
            
        }
    }
}
