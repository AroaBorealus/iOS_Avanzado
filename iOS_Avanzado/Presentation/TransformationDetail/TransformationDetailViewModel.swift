//
//  TransformationDetailViewModel.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

import Foundation

enum TransformationDetailStates{
    case ready
}

final class TransformationDetailViewModel {
    
    let transformation: DBTransformation
    var onStateChanged = Binding<TransformationDetailStates>()
    
    init(_ transformation: DBTransformation) {
        self.transformation = transformation
    }
    
    func load(){
        onStateChanged.update(.ready)
    }
}
