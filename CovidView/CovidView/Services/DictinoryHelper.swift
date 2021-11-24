//
//  DictinoryHelper.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import Foundation

class DictionaryEncoder {
    
    let encoder = JSONEncoder()
    
    func encode<T>(_ value: T) throws -> [String: Any] where T: Encodable {
        let data = try encoder.encode(value)
        return try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String: Any]
    }
}

class DictionaryDecoder {
    
    let decoder = JSONDecoder()
    
    func decode<T>(_ type: T.Type, from dictionary: [String: Any]) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return try decoder.decode(type, from: data)
    }
}
