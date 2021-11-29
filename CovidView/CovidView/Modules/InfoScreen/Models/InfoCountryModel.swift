//
//  InfoCountryModel.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/25/21.
//

import Foundation

struct InfoCountryModel: Codable {
    var id: String
    var name: String
    var code: String
    var province: String
    var city: String
    var cityCode: String
    var lat: Double
    var lon: Double
    var confirmed: Int
    var deaths: Int
    var recovered: Int
    var active: Int
    var date: String
    
    init(id: String, name: String,
         code: String, province: String,
         city: String, cityCode: String,
         lat: Double, lon: Double,
         confirmed: Int, deaths: Int,
         recovered: Int, active: Int, date: String) {
        
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
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
        province = try container.decode(String.self, forKey: .province)
        city = try container.decode(String.self, forKey: .city)
        cityCode = try container.decode(String.self, forKey: .cityCode)
        lat = Double(try container.decode(String.self, forKey: .lat)) ?? 0.0
        lon = Double(try container.decode(String.self, forKey: .lon)) ?? 0.0
        confirmed = try container.decode(Int.self, forKey: .confirmed)
        deaths = try container.decode(Int.self, forKey: .deaths)
        recovered = try container.decode(Int.self, forKey: .recovered)
        active = try container.decode(Int.self, forKey: .active)
        date = try container.decode(String.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(province, forKey: .province)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(cityCode, forKey: .cityCode)
        try container.encodeIfPresent("\(lat)", forKey: .lat)
        try container.encodeIfPresent("\(lon)", forKey: .lon)
        try container.encodeIfPresent(confirmed, forKey: .confirmed)
        try container.encodeIfPresent(deaths, forKey: .deaths)
        try container.encodeIfPresent(recovered, forKey: .recovered)
        try container.encodeIfPresent(active, forKey: .active)
        try container.encodeIfPresent(date, forKey: .date)
    }
}
