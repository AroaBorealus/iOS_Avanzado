//
//  LoginViewModel.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 15/10/24.
//

import Foundation

enum LoginState: Equatable {
    case logging
    case error(reason: String)
    case ready
}

final class LoginViewModel {
    var onStateChanged = Binding<LoginState>()
    
    func load() {
        onStateChanged.update(.logging)
    }
    
    func login(_ username: String?, _ password: String?){
        
    }
}
