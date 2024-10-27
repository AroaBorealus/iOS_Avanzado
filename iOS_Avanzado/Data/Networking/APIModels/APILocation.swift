//
//  DBLocation.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 24/10/24.
//

import Foundation

struct APILocation: Codable{
    var id: String
    var latitud: String
    var longitud: String
    var dateShow: String
    let hero: Dictionary<String,String>
}

struct CustomCodableAPILocation: Codable {
    let id: String
    let latitud: String
    let longitud: String
    let dateShow: String
    let hero: Dictionary<String,String>
}

extension CustomCodableAPILocation {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case latitud = "latitud"
        case longitud = "longitud"
        case dateShow = "dateShow"
        case hero = "hero"
    }
}
