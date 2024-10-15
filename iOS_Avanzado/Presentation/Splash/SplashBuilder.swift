//
//  SplashBuilder.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 15/10/24.
//

import UIKit

final class SplashBuilder {
    func build() -> UIViewController{
        let splashViewModel = SplashViewModel()
        return SplashViewController(splashViewModel)
    }
}
