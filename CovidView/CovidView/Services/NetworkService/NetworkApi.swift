//
//  NetworkApi.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import Foundation

typealias BodyParameters = [String: Any]
typealias UrlParameters = [String: Any]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var bodyParameters: BodyParameters? { get }
    var urlParameters: UrlParameters? { get }
}

enum NetworkEndPoint: EndPointType {
    
    case getAllCountries
    
    var path: String {
        switch self {
        case .getAllCountries:
            return "/countries"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllCountries:
            return .get
        }
    }
    
    var bodyParameters: BodyParameters? {
        switch self {
        case .getAllCountries:
            return nil
        }
    }
    
    var urlParameters: UrlParameters? {
        switch self {
        case .getAllCountries:
            return nil
        }
    }
}
