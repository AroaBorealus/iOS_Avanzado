//
//  GetCharacterUseCase.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

protocol GetCharacterUseCaseContract{
    var storeDataProvider: StoreDataProvider {get set}
    func execute(_ characterId: String, completion: @escaping (Result<DBCharacter,GetCharacterUseCaseError>) -> Void)
}


final class GetCharacterUseCase: GetCharacterUseCaseContract{
    var storeDataProvider: StoreDataProvider
    
    init(_ storeDataProvider: StoreDataProvider = .shared) {
        self.storeDataProvider = storeDataProvider
    }
    
    func execute(_ characterId: String, completion: @escaping (Result<DBCharacter, GetCharacterUseCaseError>) -> Void) {
        
        if let localCharacter = storeDataProvider.fetchCharacter(characterId) {
            let character = DBCharacter(localCharacter)
            completion(.success(character))
        } else {
            completion(.failure(GetCharacterUseCaseError(reason: "Use Case Failed")))
        }
    }
}

struct GetCharacterUseCaseError: Error {
    let reason: String
}
