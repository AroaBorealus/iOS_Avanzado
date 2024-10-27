//
//  GetAllTransformationsUseCase.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import Foundation

protocol GetCharacterTransformationsUseCaseContract{
    var storeDataProvider: StoreDataProvider {get set}
    func execute(_ characterId: String, completion: @escaping (Result<[DBTransformation]?,GetCharacterTransformationsUseCaseError>) -> Void)
}


final class GetCharacterTransformationsUseCase: GetCharacterTransformationsUseCaseContract{
    var storeDataProvider: StoreDataProvider
    
    init(_ storeDataProvider: StoreDataProvider = .shared) {
        self.storeDataProvider = storeDataProvider
    }
    
    func execute(_ characterId: String, completion: @escaping (Result<[DBTransformation]?, GetCharacterTransformationsUseCaseError>) -> Void) {
        
        let localTransformations = storeDataProvider.fetchCharacterTransformations(characterId)
        
        if !localTransformations.isEmpty {
            return completion(.success(localTransformations.map({DBTransformation($0)})))
        }
        
        GetTransformationsAPIRequest(characterId: characterId).perform { [weak self] result in
            do {
                let apiTransformations = try result.get()
                self?.storeDataProvider.addTransformations(transformations: apiTransformations)
                guard let localTransformations = self?.storeDataProvider.fetchCharacterTransformations(characterId) else{
                    completion(.failure(GetCharacterTransformationsUseCaseError(reason: "Use Case Failed")))
                    return
                }
                let transformations = localTransformations.map({DBTransformation($0)})
                completion(.success(transformations))
            } catch {
                completion(.failure(GetCharacterTransformationsUseCaseError(reason: "Use Case Failed")))
            }
        }
    }
}

struct GetCharacterTransformationsUseCaseError: Error {
    let reason: String
}
