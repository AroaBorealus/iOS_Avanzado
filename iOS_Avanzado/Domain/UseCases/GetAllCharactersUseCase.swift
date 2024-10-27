//
//  GetAllCharactersUseCase.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

protocol GetAllCharactersUseCaseContract{
    var storeDataProvider: StoreDataProvider {get set}
    func execute(completion: @escaping (Result<[DBCharacter]?,GetAllCharactersUseCaseError>) -> Void)
}


final class GetAllCharactersUseCase: GetAllCharactersUseCaseContract{
    var storeDataProvider: StoreDataProvider
    
    init(_ storeDataProvider: StoreDataProvider = .shared) {
        self.storeDataProvider = storeDataProvider
    }
    
    func execute(completion: @escaping (Result<[DBCharacter]?, GetAllCharactersUseCaseError>) -> Void) {
        
        let localCharacters = storeDataProvider.fetchAllCharacters()
        
        if !localCharacters.isEmpty {
            let characters = localCharacters.map({DBCharacter($0)})
            completion(.success(characters))
            return
        }
        
        GetCharactersAPIRequest(characterName: "").perform { [weak self] result in
            do {
                let apiCharacters = try result.get()
                self?.storeDataProvider.addCharacters(characters: apiCharacters)
                guard let localCharacters = self?.storeDataProvider.fetchAllCharacters() else{
                    completion(.failure(GetAllCharactersUseCaseError(reason: "Use Case Failed")))
                    return
                }
                let characters = localCharacters.map({DBCharacter($0)})
                completion(.success(characters))
            } catch {
                completion(.failure(GetAllCharactersUseCaseError(reason: "Use Case Failed")))
            }
        }
    }
}

struct GetAllCharactersUseCaseError: Error {
    let reason: String
}
