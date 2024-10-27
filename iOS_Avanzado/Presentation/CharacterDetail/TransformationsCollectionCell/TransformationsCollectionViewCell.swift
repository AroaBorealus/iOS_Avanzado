//
//  TransformationsCollectionViewCell.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

import UIKit
import Kingfisher

class TransformationsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var transformationImage: UIImageView!
    @IBOutlet weak var transformationName: UILabel!
    static let reuseIdentifier = "TransformationsCollectionViewCell"
    static var nib: UINib { UINib(nibName: "TransformationsCollectionViewCell", bundle: Bundle(for: TransformationsCollectionViewCell.self)) }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setImage(_ transformationPhoto: String) {
        let options = KingfisherOptionsInfo([.transition(.fade(0.1)), .forceTransition])
        transformationImage.kf.setImage(with: URL(string: transformationPhoto), options: options)
    }

    func setName(_ transformationName: String) {
        self.transformationName.text = transformationName
    }

}
