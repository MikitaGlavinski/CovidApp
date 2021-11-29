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
    
    override func viewWillDisappear(_ animated: Bool) {
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
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension RegisterViewController: RegisterViewInput {
    func showError(_ error: Error) {
        blurView.isHidden = true
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
