//
//  DBLocation.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 24/10/24.
//

import MapKit

struct DBLocation: Equatable{
    let id: String
    let latitud: String
    let longitud: String
    let dateShow: String
    let characterId: String
    
    init(_ coreDBLocation: CoreDBLocation) {
        self.id = coreDBLocation.id ?? ""
        self.latitud = coreDBLocation.latitude ?? ""
        self.longitud = coreDBLocation.longitude ?? ""
        self.dateShow = coreDBLocation.date ?? ""
        self.characterId = coreDBLocation.character?.id ?? ""
    }
}

extension DBLocation {
    var coordinate: CLLocationCoordinate2D? {
        guard let latitud = Double(self.latitud),
              let longitud = Double(self.longitud),
              abs(latitud) <= 90,
              abs(longitud) <= 180 else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
              
    }
}
