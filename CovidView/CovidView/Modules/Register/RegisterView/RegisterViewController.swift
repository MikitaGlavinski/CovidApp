//
//  RegisterViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/29/21.
//

import UIKit

protocol RegisterViewInput: AnyObject {
    func showError(_ error: Error)
}

class RegisterViewController: UIViewController {
    
    var viewModel: RegisterViewModelProtocol!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.viewDissapeared()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if emailTextfield.text?.isEmpty == true || passwordTextfield.text?.isEmpty == true {
            emailTextfield.frame.origin.x += 20
            passwordTextfield.frame.origin.x += 20
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.emailTextfield.frame.origin.x -= 20
                self.passwordTextfield.frame.origin.x -= 20
            }
            UIView.animate(withDuration: 0.5) {
                if self.emailTextfield.text?.isEmpty == true {
                    self.emailLabel.alpha = 1
                }
                if self.passwordTextfield.text?.isEmpty == true {
                    self.passwordLabel.alpha = 1
                }
            } completion: { _ in
                UIView.animate(withDuration: 1, delay: 4, options: .curveLinear) {
                    self.emailLabel.alpha = 0
                    self.passwordLabel.alpha = 0
                }
            }
        } else {
            blurView.isHidden = false
            activityIndicator.startAnimating()
            guard
                let email = emailTextfield.text?.lowercased(),
                let password = passwordTextfield.text
            else {
                return
            }
            viewModel.createAccount(with: email, password: password)
        }
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension RegisterViewController: RegisterViewInput {
    func showError(_ error: Error) {
        blurView.isHidden = true
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: String(localized: "Error"), message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: String(localized: "Ok"), style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
