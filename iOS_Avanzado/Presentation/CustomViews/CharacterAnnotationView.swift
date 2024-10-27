//
//  CharacterAnnotationView.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

import MapKit


/// Clase que nos permite mostrar una vista custom para una annotation
class CharacterAnnotationView: MKAnnotationView {
    static var  identifier: String {
        return String(describing: CharacterAnnotationView.self)
    }

    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        // PAra centrar en el punto de la coordenada
        self.centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        self.canShowCallout = true
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .clear
        let view = UIImageView(image: UIImage(resource: .dragonBall))
        addSubview(view)
        view.frame = self.frame
    }
}

