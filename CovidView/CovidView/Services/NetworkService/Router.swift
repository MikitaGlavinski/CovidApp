//
//  Router.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import Foundation

protocol RouterProtocol {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ())
    func cancel()
}

class Router<EndPoint: EndPointType>: RouterProtocol {
    
    var baseURL: URL
    var task: URLSessionTask?
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func request(_ route: EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 20)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            try configureParameters(bodyParameters: route.bodyParameters, urlParameters: route.urlParameters, request: &request)
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: BodyParameters?,
                                     urlParameters: UrlParameters?,
                                     request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try ParametersEncoder.encodeBodyParameters(request: &request, parameters: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try ParametersEncoder.encodeURLParameters(request: &request, parameters: urlParameters)
            }
        } catch {
            throw error
        }
    }
}
