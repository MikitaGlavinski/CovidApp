//
//  CountryModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import Foundation

struct CountryModel: Codable {
    var name: String
    var slug: String
    var abbr: String
    
    init(name: String, slug: String, abbr: String) {
        self.name = name
        self.slug = slug
        self.abbr = abbr
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case slug = "Slug"
        case abbr = "ISO2"
    }
}
