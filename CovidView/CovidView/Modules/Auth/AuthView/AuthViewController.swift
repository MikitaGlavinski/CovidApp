//
//  AuthViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/29/21.
//

import UIKit
import GoogleSignIn
import Firebase

protocol AuthViewInput: AnyObject {
    func showError(_ error: Error)
}

class AuthViewController: UIViewController {
    
    var viewModel: AuthViewModelProtocol!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
    }
    
    private func addGestures() {
        let googleTap = UITapGestureRecognizer(target: self, action: #selector(googleTapped))
        googleButton.addGestureRecognizer(googleTap)
        
        let hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTap)
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
    
    @objc private func googleTapped() {
        blurView.isHidden = false
        activityIndicator.startAnimating()
        viewModel.googleTapped()
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
