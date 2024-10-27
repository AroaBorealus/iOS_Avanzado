//
//  DBCharacter.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

struct DBCharacter: Equatable{
    var name: String
    var photo: String
    var id: String
    var description: String
    let favorite: Bool
    
    init(){
        self.name = ""
        self.photo = ""
        self.id = ""
        self.description = ""
        self.favorite = false
    }
    
    init(_ coreDBCharacter: CoreDBCharacter) {
        self.name = coreDBCharacter.name ?? ""
        self.photo = coreDBCharacter.photo ?? ""
        self.id = coreDBCharacter.id ?? ""
        self.description = coreDBCharacter.detail ?? ""
        self.favorite = coreDBCharacter.favorite
    }
    
    
}
