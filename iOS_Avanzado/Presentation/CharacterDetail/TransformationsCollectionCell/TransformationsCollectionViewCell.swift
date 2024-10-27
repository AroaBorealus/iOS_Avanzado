//
//  TransformationsCollectionViewCell.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

import UIKit

class TransformationsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var transformationImage: AsyncImageView!
    @IBOutlet weak var transformationName: UILabel!
    static let reuseIdentifier = "TransformationsCollectionViewCell"
    static var nib: UINib { UINib(nibName: "TransformationsCollectionViewCell", bundle: Bundle(for: TransformationsCollectionViewCell.self)) }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        transformationImage.cancel()
    }
    
    func setImage(_ transformationPhoto: String) {
        self.transformationImage.setImage(transformationPhoto)
    }

    func setName(_ transformationName: String) {
        self.transformationName.text = transformationName
    }

}
