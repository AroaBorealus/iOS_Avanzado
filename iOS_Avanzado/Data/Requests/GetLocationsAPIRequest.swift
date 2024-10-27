//
//  GetLocationsAPIRequest.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 26/10/24.
//

import Foundation

struct GetLocationsAPIRequest: APIRequest {
    typealias Response = [APILocation]
    
    let method: HTTPMethod = .POST
    let path: String = "/api/heros/locations"
    let body: (any Encodable)?
    
    init(characterId: String) {
        body = RequestEntity(id: characterId)
    }
}

extension GetLocationsAPIRequest {
    struct RequestEntity: Encodable {
        let id: String
    }
}

