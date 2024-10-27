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
    case existingToken
}

final class SplashViewModel {
    
    var onStateChanged = Binding<SplashState>()
    private let sessionDataSource: SessionDataSourcesContract = SessionDataSources()
    
    func load() {
        onStateChanged.update(.loading)
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            
            if (self?.sessionDataSource.hasSession() == true) {
                self?.onStateChanged.update(.existingToken)
                return
            }
            self?.onStateChanged.update(.loaded)
        }
//        do{
//            try StoreDataProvider.shared.clearBBDD()
//        } catch{
//            
//        }
//        self.onStateChanged.update(.loaded)
    }
}
