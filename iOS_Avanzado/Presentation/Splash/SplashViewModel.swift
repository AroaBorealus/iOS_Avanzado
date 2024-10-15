//
//  SplashViewModel.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 15/10/24.
//

import Foundation

enum SplashState {
    case loading
    case error
    case loaded
}

final class SplashViewModel {
    
    var onStateChanged = Binding<SplashState>()
    
    func load() {
        onStateChanged.update(.loading)
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.onStateChanged.update(.loaded)
        }
    }
}
