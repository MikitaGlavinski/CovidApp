//
//  AuthViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/29/21.
//

import UIKit
import GoogleSignIn
import Firebase
import FBSDKLoginKit

protocol AuthViewInput: AnyObject {
    func showError(_ error: Error)
}

class AuthViewController: UIViewController {
    
    var viewModel: AuthViewModelProtocol!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var googleButton: UIButton!
    
    private lazy var facebookButton: FBLoginButton = {
        let button = FBLoginButton()
        button.delegate = self
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
//        configureFacebookButton()
    }
    
    private func addGestures() {
        let hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTap)
    }
    
    private func configureFacebookButton() {
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        facebookButton.frame = CGRect(x: 50, y: googleButton.frame.maxY + navBarHeight + 30, width: view.bounds.width - 100, height: 40)
        view.insertSubview(facebookButton, belowSubview: blurView)
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        blurView.isHidden = false
        activityIndicator.startAnimating()
        guard
            let email = emailTextfield.text?.lowercased(),
            let password = passwordTextfield.text
        else {
            return
        }
        viewModel.signInTapped(email: email, password: password)
    }
    
    @IBAction func googleTapped(_ sender: Any) {
        blurView.isHidden = false
        activityIndicator.startAnimating()
        viewModel.googleTapped()
    }
    
    @IBAction func facebookTapped(_ sender: Any) {
        facebookButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        viewModel.createAccount()
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension AuthViewController: AuthViewInput {
    func showError(_ error: Error) {
        blurView.isHidden = true
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension AuthViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        blurView.isHidden = false
        activityIndicator.startAnimating()
        if let error = error {
            showError(error)
            return
        }
        guard let token = AccessToken.current?.tokenString else {
            blurView.isHidden = true
            activityIndicator.stopAnimating()
            return
        }
        viewModel.facebookSignIn(token: token)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
}
