//
//  CharacterDetailBuilder.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 26/10/24.
//

import UIKit

final class CharacterDetailBuilder {
    
    let characterId: String
    
    init(_ characterId: String) {
        self.characterId = characterId
    }
    
    func build() -> UIViewController{
        let characterUseCase = GetCharacterUseCase()
        let transformationsUseCase = GetCharacterTransformationsUseCase()
        let locationsUseCase = GetCharacterLocationsUseCase()
        let viewModel = CharacterDetailViewModel(characterUseCase, transformationsUseCase, locationsUseCase, characterId)
        let viewController = CharacterDetailViewController(viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
