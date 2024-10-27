//
//  StoreDataProvider.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 24/10/24.
//

import CoreData

enum TypePersistency {
    case disk
    case inMemory
}

final class StoreDataProvider {
    private let persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext{
        persistentContainer.viewContext
    }
    
    static var shared = StoreDataProvider()
    static var managedModel: NSManagedObjectModel = {
        let bundle = Bundle(for: StoreDataProvider.self)
        guard let url = bundle.url(forResource: "Model", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Error loading model")
        }
        return model
    }()
    
    private let persistency: TypePersistency

    init(_ persistency: TypePersistency = .disk) {
        self.persistency = persistency
        self.persistentContainer = NSPersistentContainer(name: "Model", managedObjectModel: Self.managedModel)
        if self.persistency == .inMemory {
            let persistentStore = persistentContainer.persistentStoreDescriptions.first
            persistentStore?.url = URL(filePath: "/dev/null")
        }
        self.persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Error loading DB: \(error.localizedDescription)")
            }
        }
    }
    
    private func save(){
        if context.hasChanges{
            do {
                try context.save()
            } catch {
                debugPrint("Error saving changes: \(error.localizedDescription)")
            }
        }
    }
    
    func clearBBDD() throws {
        let batchDeleteCharacters = NSBatchDeleteRequest(fetchRequest: CoreDBCharacter.fetchRequest())
        let batchDeleteTransformations = NSBatchDeleteRequest(fetchRequest: CoreDBTransformation.fetchRequest())
        let batchDeleteLocations = NSBatchDeleteRequest(fetchRequest: CoreDBLocation.fetchRequest())

        do {
            try context.execute(batchDeleteCharacters)
            try context.execute(batchDeleteTransformations)
            try context.execute(batchDeleteLocations)
            context.reset()
        } catch {
            print("Error al limpiar la base de datos: \(error.localizedDescription)")
            throw error
        }
    }
}

extension StoreDataProvider {
    
    func fetchAllCharacters() -> [CoreDBCharacter]{
        let request = CoreDBCharacter.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            debugPrint("Error loading Characters: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchCharacter(_ id: String) -> CoreDBCharacter? {
        let request = CoreDBCharacter.fetchRequest()
        
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        
        do {
            return try context.fetch(request).first
        } catch {
            debugPrint("Error loading Characters: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchCharacterTransformations(_ characterId: String) -> [CoreDBTransformation] {
        let request = CoreDBTransformation.fetchRequest()
        
        let predicate = NSPredicate(format: "character.id == %@", characterId)
        request.predicate = predicate
        
        do {
            return try context.fetch(request)
        } catch {
            debugPrint("Error loading Transformations: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchTransformation(_ id: String) -> CoreDBTransformation? {
        let request = CoreDBTransformation.fetchRequest()
        
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        
        do {
            return try context.fetch(request).first
        } catch {
            debugPrint("Error loading Transformation: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchCharacterLocations(_ characterId: String) -> [CoreDBLocation] {
        let request = CoreDBLocation.fetchRequest()
        
        let predicate = NSPredicate(format: "character.id == %@", characterId)
        request.predicate = predicate
        
        do {
            return try context.fetch(request)
        } catch {
            debugPrint("Error loading Locations: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchLocations(_ id: String) -> CoreDBLocation? {
        let request = CoreDBLocation.fetchRequest()
        
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        
        do {
            return try context.fetch(request).first
        } catch {
            debugPrint("Error loading Location: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    func addCharacters(characters: [APICharacter]) {
        for character in characters {
            let newCharacter = CoreDBCharacter(context: context)
            newCharacter.id = character.id
            newCharacter.name = character.name
            newCharacter.photo = character.photo
            newCharacter.detail = character.description
            newCharacter.favorite = character.favorite
        }
        save()
    }
    
    func addTransformations(transformations: [APITransformation]) {
        for transformation in transformations {
            let newTransformation = CoreDBTransformation(context: context)
            newTransformation.id = transformation.id
            newTransformation.name = transformation.name
            newTransformation.detail = transformation.description
            newTransformation.photo = transformation.photo
            
            if let characterId = transformation.hero["id"]{
                newTransformation.character = fetchCharacter(characterId)
            }
        }
        save()
    }
    
    func addLocations(locations: [APILocation]) {
        for location in locations {
            let newLocation = CoreDBLocation(context: context)
            newLocation.id = location.id
            newLocation.date = location.dateShow
            newLocation.latitude = location.latitud
            newLocation.longitude = location.longitud
            
            if let characterId = location.hero["id"]{
                newLocation.character = fetchCharacter(characterId)
            }
        }
        save()
    }
}
