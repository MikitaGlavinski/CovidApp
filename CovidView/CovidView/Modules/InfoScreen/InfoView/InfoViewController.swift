//
//  InfoViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import UIKit

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
    
//    private lazy var backgroundContainerView: UIView = {
//        let view = UIView()
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = appearance.gradientColors
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: UIScreen.main.bounds.height * 0.5)
//        view.layer.insertSublayer(gradientLayer, at: 0)
//        return view
//    }()
//
//    private lazy var doctorImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .clear
//        imageView.image = UIImage.doctorCorona
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//
//    private lazy var recommendLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.numberOfLines = 2
//        label.font = UIFont.poppinsMedium(with: 18)
//        let attrString = NSMutableAttributedString(string: "All you need\nis stay at home.")
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 3
//        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
//        label.attributedText = attrString
//        return label
//    }()
//
//    private lazy var menuButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage.menu, for: .normal)
//        button.tintColor = .white
//        return button
//    }()
//
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = .clear
//        scrollView.showsVerticalScrollIndicator = false
//        return scrollView
//    }()
//
//    private lazy var containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .clear
//        return view
//    }()
//
//    private lazy var virusImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .clear
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage.virus
//        return imageView
//    }()
//
//    private lazy var spreadView: SpreadView = {
//        let view = SpreadView()
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
//        scrollView.contentInsetAdjustmentBehavior = .never
//        view.backgroundColor = .white
//        addSubviews()
//        makeConstraints()
    }
    
//    private func addSubviews() {
//        view.addSubview(backgroundContainerView)
//        view.addSubview(doctorImageView)
//        view.addSubview(recommendLabel)
//        view.addSubview(menuButton)
//        view.addSubview(scrollView)
//        scrollView.addSubview(containerView)
//        containerView.addSubview(virusImageView)
//        containerView.addSubview(spreadView)
//    }
    
//    private func makeConstraints() {
//        backgroundContainerView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        backgroundContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        backgroundContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        backgroundContainerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//
//        doctorImageView.translatesAutoresizingMaskIntoConstraints = false
//        doctorImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: appearance.doctorImageViewLeadingMargin).isActive = true
//        doctorImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: appearance.doctorImageViewTopMargin).isActive = true
//        doctorImageView.widthAnchor.constraint(equalToConstant: appearance.doctorImageViewWidth).isActive = true
//        doctorImageView.heightAnchor.constraint(equalToConstant: appearance.doctorImageViewHeight).isActive = true
//
//        recommendLabel.translatesAutoresizingMaskIntoConstraints = false
//        recommendLabel.topAnchor.constraint(equalTo: doctorImageView.topAnchor, constant: appearance.recommendLabelTopMargin).isActive = true
//        recommendLabel.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: appearance.recommendLabelLeadingMargin).isActive = true
//
//        menuButton.translatesAutoresizingMaskIntoConstraints = false
//        menuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: appearance.menuButtonTopMargin).isActive = true
//        menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: appearance.menuButtonTrailingMargin).isActive = true
//        menuButton.heightAnchor.constraint(equalToConstant: appearance.menuButtomHeight).isActive = true
//        menuButton.widthAnchor.constraint(equalToConstant: appearance.menuButtonWidth).isActive = true
//
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//
//        virusImageView.translatesAutoresizingMaskIntoConstraints = false
//        virusImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 45).isActive = true
//        virusImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
//        virusImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
//        virusImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
//
//        spreadView.translatesAutoresizingMaskIntoConstraints = false
//        spreadView.topAnchor.constraint(equalTo: virusImageView.bottomAnchor).isActive = true
//        spreadView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
//        spreadView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
//        spreadView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
//        spreadView.heightAnchor.constraint(equalToConstant: 800).isActive = true
//    }
}

extension InfoViewController: InfoViewInput {
    
}
