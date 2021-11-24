//
//  InfoViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import UIKit
import MapKit

protocol InfoViewInput: AnyObject {
    
}

extension InfoViewController {
    struct Appearance {
        let gradientColors = [UIColor(red: 49/255, green: 125/255, blue: 202/255, alpha: 1).cgColor, UIColor(red: 17/255, green: 37/255, blue: 159/255, alpha: 1).cgColor]
        let doctorImageViewWidth: CGFloat = 200
        let doctorImageViewTopMargin: CGFloat = 60
        let doctorImageViewLeadingMargin: CGFloat = 30
        let doctorImageViewHeight: CGFloat = 300
        let recommendLabelTopMargin: CGFloat = 35
        let recommendLabelLeadingMargin: CGFloat = -60
        let menuButtomHeight: CGFloat = 25
        let menuButtonWidth: CGFloat = 40
        let menuButtonTopMargin: CGFloat = 45
        let menuButtonTrailingMargin: CGFloat = -5
    }
}

class InfoViewController: UIViewController {
    
    private let appearance = Appearance()
    var viewModel: InfoViewModelProtocol!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        mapView.layer.cornerRadius = 20
        scrollView.delegate = self
    }
}

extension InfoViewController: InfoViewInput {
    
}

extension InfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.frame.origin.y = max(0, (-scrollView.contentOffset.y) / 5)
//        view.frame.origin.y = max(0, (-scrollView.contentOffset.y))
        view.layer.sublayers?[0].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: max(UIScreen.main.bounds.height / 2, -scrollView.contentOffset.y * 2.8))
        print(-scrollView.contentOffset.y)
    }
}
