//
//  NetworkService.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import Foundation

protocol NetworkServiceProtocol {
    func getAllCountries(completion: @escaping (Result<[CountryModel], Error>) -> ())
}

class NetworkService {
    
    static var shared = NetworkService()
    
    init() {}
    
    let router = Router<NetworkEndPoint>(baseURL: URL(string: "https://api.covid19api.com")!)
    
    private func routerRequest<T: Codable>(_ route: NetworkEndPoint, decodeType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        router.request(route) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.decodingFailed))
                return
            }
            
            if (200...299).contains(response.statusCode) {
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let apiResponse: T = try JSONDecoder().decode(decodeType, from: data)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(NetworkError.decodingFailed))
                }
            } else {
                completion(.failure(NetworkError.unrecognized))
            }
        }
    }
}

extension NetworkService: NetworkServiceProtocol {
    
    func getAllCountries(completion: @escaping (Result<[CountryModel], Error>) -> ()) {
        routerRequest(.getAllCountries, decodeType: [CountryModel].self, completion: completion)
    }
    
    
}
