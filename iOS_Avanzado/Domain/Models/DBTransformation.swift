//
//  DBTransformation.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

struct DBTransformation: Decodable{
    var name: String
    var photo: String
    var id: String
    var description: String
    let hero: Dictionary<String,String>
}

struct CustomCodableTransformation: Codable {
    let nombreCompleto: String
    let fotoURL: String
    let id: String
    let descripcion: String
    let hero: Dictionary<String,String>
}

extension CustomCodableTransformation {
    enum CodingKeys: String, CodingKey {
        case nombreCompleto = "name"
        case fotoURL = "photo"
        case id = "id"
        case descripcion = "description"
        case hero = "hero"
    }
}
