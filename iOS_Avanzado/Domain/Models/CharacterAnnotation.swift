//
//  CharacterAnnotation.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

import MapKit

class CharacterAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
