//
//  ParametersEncoder.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import Foundation

enum NetworkError: String, Error {
    case encodingFailed = "Failed to encode data."
    case decodingFailed = "Failed to decode data."
    case noData = "No data."
    case unrecognized = "Unrecognized error."
}

class ParametersEncoder {
    
    static func encodeBodyParameters(request: inout URLRequest, parameters: BodyParameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            request.httpBody = jsonData
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
    static func encodeURLParameters(request: inout URLRequest, parameters: UrlParameters) throws {
        
        guard let url = request.url else { throw NetworkError.encodingFailed }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
    }
}
