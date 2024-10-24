//
//  SplashViewController.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 15/10/24.
//

import UIKit

class SplashViewController: UIViewController {

    private let viewModel: SplashViewModel
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    init(_ splashViewModel: SplashViewModel) {
        self.viewModel = splashViewModel
        super.init(nibName: "SplashView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }
    
    private func bind(){
        viewModel.onStateChanged.bind { [weak self] SplashState in
            switch SplashState {
            case .loading:
                self?.setAnimation(true)
            case .loaded:
                self?.setAnimation(false)
                self?.present(LoginBuilder().build(), animated: true)
            case .existingToken:
                self?.setAnimation(false)
                self?.present(HomeBuilder().build(), animated: true)
            case .error:
                break
            }
        }
    }
    
    private func setAnimation(_ animating: Bool) {
        switch activityIndicator.isAnimating {
        case true where !animating:
            activityIndicator.stopAnimating()
        case false where animating:
            activityIndicator.startAnimating()
        default:
            break
        }
    }

}
