//
//  GetLocationOfCharacterUseCase.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 26/10/24.
//

import Foundation

protocol GetCharacterLocationsUseCaseContract{
    var storeDataProvider: StoreDataProvider {get set}
    func execute(_ characterId: String, completion: @escaping (Result<[DBLocation]?,GetCharacterLocationsUseCaseError>) -> Void)
}

final class GetCharacterLocationsUseCase: GetCharacterLocationsUseCaseContract{
    var storeDataProvider: StoreDataProvider
    
    init(_ storeDataProvider: StoreDataProvider = .shared) {
        self.storeDataProvider = storeDataProvider
    }
    
    func execute(_ characterId: String, completion: @escaping (Result<[DBLocation]?, GetCharacterLocationsUseCaseError>) -> Void) {
        
        let localLocations = storeDataProvider.fetchCharacterLocations(characterId)
        
        if !localLocations.isEmpty {
            let locations = localLocations.map({DBLocation($0)})
            completion(.success(locations))
            return
        }
        
        GetLocationsAPIRequest(characterId: characterId).perform { [weak self] result in
            do {
                let apiLocations = try result.get()
                self?.storeDataProvider.addLocations(locations: apiLocations)
                guard let localLocations = self?.storeDataProvider.fetchCharacterLocations(characterId) else {
                    completion(.failure(GetCharacterLocationsUseCaseError(reason: "Use Case Failed")))
                    return
                }
                let locations = localLocations.map({DBLocation($0)})
                completion(.success(locations))
            } catch {
                completion(.failure(GetCharacterLocationsUseCaseError(reason: "Use Case Failed")))
            }
        }
    }
}


struct GetCharacterLocationsUseCaseError: Error {
    let reason: String
}
