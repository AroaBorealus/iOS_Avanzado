//
//  CharacterCollectionViewCell.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 23/10/24.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CharacterCollectionViewCell"
    static var nib: UINib { UINib(nibName: "CharacterCollectionViewCell", bundle: Bundle(for: CharacterCollectionViewCell.self)) }
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setImage(_ characterPhoto: String) {
        let options = KingfisherOptionsInfo([.transition(.fade(0.1)), .forceTransition])
        characterImage.kf.setImage(with: URL(string: characterPhoto), options: options)
    }
    
    func setName (_ name: String) {
        self.characterName.text = name
    }
}
