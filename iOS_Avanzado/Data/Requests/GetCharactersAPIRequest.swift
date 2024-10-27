//
//  GetCharactersAPIRequest.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

struct GetCharactersAPIRequest: APIRequest {
    typealias Response = [APICharacter]
    
    let method: HTTPMethod = .POST
    let path: String = "/api/heros/all"
    let body: (any Encodable)?
    
    init(characterName: String) {
        body = RequestEntity(name: characterName)
    }
}

extension GetCharactersAPIRequest {
    struct RequestEntity: Encodable {
        let name: String
    }
}
