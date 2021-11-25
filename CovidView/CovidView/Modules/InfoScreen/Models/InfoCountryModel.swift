//
//  InfoCountryModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/25/21.
//

import Foundation

struct InfoCountryModel: Codable {
    var id: String?
    var name: String?
    var code: String?
    var province: String?
    var city: String?
    var cityCode: String?
    var lat: Double?
    var lon: Double?
    var confirmed: Int?
    var deaths: Int?
    var recovered: Int?
    var active: Int?
    var date: String?
    
    init(id: String? = nil, name: String? = nil,
         code: String? = nil, province: String? = nil,
         city: String? = nil, cityCode: String? = nil,
         lat: Double? = nil, lon: Double? = nil,
         confirmed: Int? = nil, deaths: Int? = nil,
         recovered: Int? = nil, active: Int? = nil, date: String? = nil) {
        
        self.id = id
        self.name = name
        self.code = code
        self.province = province
        self.city = city
        self.cityCode = cityCode
        self.lat = lat
        self.lon = lon
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
        self.active = active
        self.date = date
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Country"
        case code = "CountryCode"
        case province = "Province"
        case city = "City"
        case cityCode = "CityCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        province = try container.decodeIfPresent(String.self, forKey: .province)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        cityCode = try container.decodeIfPresent(String.self, forKey: .cityCode)
        lat = Double(try container.decodeIfPresent(String.self, forKey: .lat) ?? "0.0")
        lon = Double(try container.decodeIfPresent(String.self, forKey: .lon) ?? "0.0")
        confirmed = try container.decodeIfPresent(Int.self, forKey: .confirmed)
        deaths = try container.decodeIfPresent(Int.self, forKey: .deaths)
        recovered = try container.decodeIfPresent(Int.self, forKey: .recovered)
        active = try container.decodeIfPresent(Int.self, forKey: .active)
        date = try container.decodeIfPresent(String.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(province, forKey: .province)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(cityCode, forKey: .cityCode)
        try container.encodeIfPresent("\(lat ?? 0.0)", forKey: .lat)
        try container.encodeIfPresent("\(lon ?? 0.0)", forKey: .lon)
        try container.encodeIfPresent(confirmed, forKey: .confirmed)
        try container.encodeIfPresent(deaths, forKey: .deaths)
        try container.encodeIfPresent(recovered, forKey: .recovered)
        try container.encodeIfPresent(active, forKey: .active)
        try container.encodeIfPresent(date, forKey: .date)
    }
}
