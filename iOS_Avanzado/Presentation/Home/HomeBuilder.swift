//
//  HomeBuilder.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 17/10/24.
//

import UIKit

final class HomeBuilder {
    func build() -> UIViewController {
        let useCase = GetAllCharactersUseCase()
        let viewModel = HomeViewModel(useCase)
        let viewController = HomeViewController(viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
//        navigationController.navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .add, target: self, action: nil
//        )
        
        return navigationController
    }
}
