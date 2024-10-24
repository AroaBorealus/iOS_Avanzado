//
//  LoginBuilder.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 15/10/24.
//

import UIKit

final class LoginBuilder {
    func build() -> UIViewController{
        let useCase = LoginUseCase()
        let viewModel = LoginViewModel(useCase)
        let viewController = LoginViewController(viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
