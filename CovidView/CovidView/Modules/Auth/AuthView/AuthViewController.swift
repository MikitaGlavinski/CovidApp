//
//  AuthViewController.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/29/21.
//

import UIKit
import FBSDKLoginKit
import CryptoKit
import AuthenticationServices
import Firebase

protocol AuthViewInput: AnyObject {
    func showError(_ error: Error)
}

class AuthViewController: UIViewController {
    
    var viewModel: AuthViewModelProtocol!
    private var currentNonce: String?
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    private lazy var facebookButton: FBLoginButton = {
        let button = FBLoginButton()
        button.delegate = self
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        Analytics.logEvent("open_AuthScreen", parameters: nil)
    }
    
    private func addGestures() {
        let hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTap)
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    @IBAction func signInTapped(_ sender: Any) {
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
            viewModel.signInTapped(email: email, password: password)
        }
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
    
    @IBAction func appleTapped(_ sender: Any) {
        blurView.isHidden = false
        activityIndicator.startAnimating()
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension AuthViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            viewModel.appleSignIn(idToken: idTokenString, rawNonce: nonce)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        blurView.isHidden = true
        activityIndicator.stopAnimating()
        showError(error)
    }
}

extension AuthViewController: AuthViewInput {
    func showError(_ error: Error) {
        blurView.isHidden = true
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: String(localized: "Error"), message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: String(localized: "Ok"), style: .default, handler: nil)
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
            showError(NetworkError.unrecognized)
            return
        }
        viewModel.facebookSignIn(token: token)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
}
