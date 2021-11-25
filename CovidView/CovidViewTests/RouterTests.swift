//
//  NetworkServiceTests.swift
//  CovidViewTests
//
//  Created by Mikita Glavinski on 11/25/21.
//

import XCTest
@testable import CovidView

enum MockEndPoint: EndPointType {
    
    case testCase(body: [String: Any], url: [String: Any])
    
    var path: String {
        switch self {
        case .testCase:
            return "/testPath"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .testCase:
            return .get
        }
    }
    
    var bodyParameters: BodyParameters? {
        switch self {
        case .testCase(let body, _):
            return body
        }
    }
    
    var urlParameters: UrlParameters? {
        switch self {
        case .testCase(_, let url):
            return url
        }
    }
}

class MockRouter<EndPoint: EndPointType> {
    
    var baseURL = URL(string: "https://test.com")!
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        
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
    
    func configureParameters(bodyParameters: BodyParameters?,
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

class RouterTests: XCTestCase {

    func testBuildRequest() {
        let body = ["one": 1, "two": 2]
        let url = ["one": 1, "two": 2]
        let router = MockRouter<MockEndPoint>()
        
        guard
            let request = try? router.buildRequest(from: .testCase(body: body, url: url)),
            let bodyDict = try? JSONSerialization.jsonObject(with: request.httpBody!, options: .fragmentsAllowed) as? [String: Int],
            let stringParameters = request.url?.absoluteString.components(separatedBy: "?").last?.components(separatedBy: "&"),
            let mainUrl = request.url?.absoluteString.components(separatedBy: "?").first
        else {
            XCTFail()
            return
        }
        
        let urlSet = Set(["one=1", "two=2"])
        let paramSet = Set(stringParameters)
        
        XCTAssertEqual(urlSet, paramSet, "Test build request failed.")
        XCTAssertEqual(body, bodyDict, "Test build request failed.")
        XCTAssertEqual("GET", request.httpMethod, "Test build request failed.")
        XCTAssertEqual("https://test.com/testPath", mainUrl, "Test build request failed.")
    }

}
