//
//  GetTransformationsAPIRequest.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

struct GetTransformationsAPIRequest: APIRequest {
    typealias Response = [APITransformation]
    
    let method: HTTPMethod = .POST
    let path: String = "/api/heros/tranformations"
    let body: (any Encodable)?
    
    init(characterId: String) {
        body = RequestEntity(id: characterId)
    }
}

extension GetTransformationsAPIRequest {
    struct RequestEntity: Encodable {
        let id: String
    }
}
