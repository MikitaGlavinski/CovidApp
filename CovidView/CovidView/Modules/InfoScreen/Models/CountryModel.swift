//
//  CountryModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import Foundation

struct CountryModel: Codable {
    var name: String?
    var slug: String?
    var abbr: String?
    
    init(name: String? = nil, slug: String? = nil, abbr: String? = nil) {
        self.name = name
        self.slug = slug
        self.abbr = abbr
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case slug = "Slug"
        case abbr = "ISO2"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        slug = try container.decodeIfPresent(String.self, forKey: .slug)
        abbr = try container.decodeIfPresent(String.self, forKey: .abbr)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(slug, forKey: .slug)
        try container.encodeIfPresent(abbr, forKey: .abbr)
    }
}
