//
//  TransformationDetailViewController.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

import UIKit
import Kingfisher

class TransformationDetailViewController: UIViewController {

    @IBOutlet weak var transformationImage: UIImageView!
    @IBOutlet weak var transformationName: UILabel!
    @IBOutlet weak var transformaitonDescription: UILabel!
    
    let viewModel: TransformationDetailViewModel
    
    init(_ viewModel: TransformationDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "TransformationDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }

    func bind(){
        viewModel.onStateChanged.bind {[weak self] state in
            switch state {
            case .ready:
                self?.caseReady()
            }
        }
    }
    
    func caseReady(){
        transformationName.text = viewModel.transformation.name
        transformaitonDescription.text = viewModel.transformation.description
        
        let options = KingfisherOptionsInfo([.transition(.fade(0.1)), .forceTransition])
        transformationImage.kf.setImage(with: URL(string: viewModel.transformation.photo), options: options)
    }
}

