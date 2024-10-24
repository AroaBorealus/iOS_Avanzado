//
//  DBCharacter.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

struct DBCharacter: Decodable{
    var name: String
    var photo: String
    var id: String
    var description: String
    let favorite: Bool
}

struct CustomCodableCharacter: Codable {
    let nombreCompleto: String
    let fotoURL: String
    let id: String
    let descripcion: String
    let favorito: Bool
}

extension CustomCodableCharacter {
    enum CodingKeys: String, CodingKey {
        case nombreCompleto = "name"
        case fotoURL = "photo"
        case id = "id"
        case descripcion = "description"
        case favorito = "favorite"
    }
}
