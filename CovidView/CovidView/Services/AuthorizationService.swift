//
//  AuthorizationService.swift
//  CovidView
//
//  Created by Mikita Glavinski on 12/1/21.
//

import Foundation
import Firebase

protocol AuthorizationServiceProtocol {
    func signIn(with credential: AuthCredential, completion: @escaping (Result<String, Error>) -> ())
    func signIn(with email: String, password: String, completion: @escaping (Result<String, Error>) -> ())
    func createAccount(with email: String, password: String, completion: @escaping (Result<String, Error>) -> ())
    func signOut(completion: @escaping (Result<String, Error>) -> ())
}

class AuthorizationService: AuthorizationServiceProtocol {
    
    static var shared: AuthorizationServiceProtocol = AuthorizationService()
    
    private init() {}
    
    func signIn(with credential: AuthCredential, completion: @escaping (Result<String, Error>) -> ()) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let token = authResult?.user.uid else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(token))
        }
    }
    
    func signIn(with email: String, password: String, completion: @escaping (Result<String, Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let token = authResult?.user.uid else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(token))
        }
    }
    
    func createAccount(with email: String, password: String, completion: @escaping (Result<String, Error>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let token = authResult?.user.uid else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(token))
        }
    }
    
    func signOut(completion: @escaping (Result<String, Error>) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(.success("ok"))
        } catch {
            completion(.failure(NetworkError.unrecognized))
        }
    }
}
