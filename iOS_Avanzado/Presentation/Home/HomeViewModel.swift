//
//  HomeViewModel.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 17/10/24.
//

import Foundation

enum HomeStates: Equatable {
    case loading
    case ready
    case error(reason: String)
    case logout
}

final class HomeViewModel {
    let useCase: GetAllCharactersUseCaseContract
    var onStateChanged = Binding<HomeStates>()
    var characters: [DBCharacter] = []
    
    init(_ useCase: GetAllCharactersUseCaseContract) {
        self.useCase = useCase
    }
    
    func load() {
        onStateChanged.update(.loading)
        useCase.execute { [weak self ] result in
            switch result {
            case .success(let characterArray):
                guard let characterArrayUnwrapped = characterArray else {
                    self?.onStateChanged.update(.error(reason: "Character array not found"))
                    return
                }
                self?.characters = characterArrayUnwrapped.sorted{ $0.name < $1.name }
                self?.onStateChanged.update(.ready)
            case .failure(let error):
                self?.onStateChanged.update(.error(reason: error.reason))
            }
        }
    }
    
    func logoutProcess(){
        SessionDataSources.shared.deleteSession()
        do {
            try StoreDataProvider.shared.clearBBDD()
        } catch {
            
        }
        onStateChanged.update(.logout)
    }
    
    func reverseCharacters(){
        characters.reverse()
    }
}
