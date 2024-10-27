//
//  CharacterDetailViewModel.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 26/10/24.
//

import Foundation

enum CharacterDetailStates: Equatable {
    case loading
    case transformationsReady
    case locationsReady
    case ready
    case error(reason: String)
}

final class CharacterDetailViewModel {
    let transformationsUseCase: GetCharacterTransformationsUseCaseContract
    let locationsUseCase: GetCharacterLocationsUseCaseContract
    var onStateChanged = Binding<CharacterDetailStates>()
    var character: DBCharacter = DBCharacter()
    var transformations: [DBTransformation] = []
    var locations: [DBLocation] = []
    var annotations: [CharacterAnnotation] = []
    
    init(_ characterUseCase: GetCharacterUseCaseContract, _ transformationsUseCase: GetCharacterTransformationsUseCaseContract, _ locationsUseCase: GetCharacterLocationsUseCaseContract, _ characterId: String) {
        self.transformationsUseCase = transformationsUseCase
        self.locationsUseCase = locationsUseCase
//        DispatchQueue.main.sync{
//            
//        }
        characterUseCase.execute(characterId, completion: { [weak self] result in
            switch result{
            case .success(let character):
                self?.character = character
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        })
    }
    
    func load() {
        onStateChanged.update(.ready)
        loadTransformations()
        loadLocations()
    }
    
    private func loadTransformations() {
        transformationsUseCase.execute(character.id) { [weak self ] result in
            switch result {
            case .success(let transformationsArray):
                guard let transformationsArrayUnwrapped = transformationsArray else {
                    self?.onStateChanged.update(.error(reason: "Transformations array not found"))
                    return
                }
                self?.transformations = transformationsArrayUnwrapped.sorted{
                    let name0Arr = $0.name.components(separatedBy: ".")
                    let name1Arr = $1.name.components(separatedBy: ".")
                    
                    guard let num0Str = name0Arr.first else
                    {
                        return $0.name < $1.name
                    }
                    
                    guard let num1Str = name1Arr.first else
                    {
                        return $0.name < $1.name
                    }
                    
                    guard let int0 = Int(num0Str) else
                    {
                        return $0.name < $1.name
                    }
                    
                    guard let int1 = Int(num1Str) else
                    {
                        return $0.name < $1.name
                    }
                    
                    return int0 < int1
                }
                self?.onStateChanged.update(.transformationsReady)
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
    }
    
    private func loadLocations() {
        locationsUseCase.execute(character.id) {[weak self] result in
            switch result {
            case .success(let locations):
                guard let locationsUnwrapped = locations else {
                    self?.onStateChanged.update(.error(reason: "Locations array not found"))
                    return
                }
                self?.locations = locationsUnwrapped
                self?.createAnnotations()
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
    }
    
    
    private func createAnnotations() {
        self.annotations = []
        locations.forEach { [weak self]  location in
            guard let coordinate = location.coordinate else {
                return
            }
            let annotation = CharacterAnnotation(title: self?.character.name, subtitle: location.dateShow, coordinate: coordinate)
            self?.annotations.append(annotation)
        }
        self.onStateChanged.update(.locationsReady)
    }
}
