//
//  DBTransformation.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

struct DBTransformation: Equatable{
    var name: String
    var photo: String
    var id: String
    var description: String
    let characterId: String
    
    init(_ coreDBTransformation: CoreDBTransformation) {
        self.name = coreDBTransformation.name ?? ""
        self.photo = coreDBTransformation.photo ?? ""
        self.id = coreDBTransformation.id ?? ""
        self.description = coreDBTransformation.detail ?? ""
        self.characterId = coreDBTransformation.character?.id ?? ""
    }
}
