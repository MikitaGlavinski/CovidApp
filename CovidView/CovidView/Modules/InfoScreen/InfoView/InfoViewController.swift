//
//  InfoViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = MainView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 500))
        view.addSubview(mainView)
    }
}

extension InfoViewController: InfoViewInput {
    
}
