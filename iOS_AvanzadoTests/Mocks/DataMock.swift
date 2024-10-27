//
//  DataMock.swift
//  iOS_AvanzadoTests
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

import Foundation
@testable import iOS_Avanzado

final class DataMock{
    
    static private func loadCharactersData() throws -> Data {
        let bundle = Bundle(for: DataMock.self)
        guard let url = bundle.url(forResource: "Characters", withExtension: "json"),
              let data = try? Data.init(contentsOf: url)  else {
            throw NSError(domain: "com.aroaborealus.iOS-Avanzado", code: -1)
        }
        return data
    }
    
    static private func loadLocationsData() throws -> Data {
        let bundle = Bundle(for: DataMock.self)
        guard let url = bundle.url(forResource: "Locations", withExtension: "json"),
              let data = try? Data.init(contentsOf: url)  else {
            throw NSError(domain: "com.aroaborealus.iOS-Avanzado", code: -1)
        }
        return data
    }
    
    static private func loadTransformationsData() throws -> Data {
        let bundle = Bundle(for: DataMock.self)
        guard let url = bundle.url(forResource: "Transformations", withExtension: "json"),
              let data = try? Data.init(contentsOf: url)  else {
            throw NSError(domain: "com.aroaborealus.iOS-Avanzado", code: -1)
        }
        return data
    }
    
    static func mockCharacters() throws -> [APICharacter] {
        do {
            let data = try self.loadCharactersData()
            let characters = try JSONDecoder().decode([APICharacter].self, from: data)
            return characters
        } catch {
            throw error
        }
    }
    
    static func mockTransformations() throws -> [APITransformation] {
        do {
            let data = try self.loadTransformationsData()
            let transformations = try JSONDecoder().decode([APITransformation].self, from: data)
            return transformations
        } catch {
            throw error
        }
    }
    
    static func mockLocations() throws -> [APILocation] {
        do {
            let data = try self.loadLocationsData()
            let locations = try JSONDecoder().decode([APILocation].self, from: data)
            return locations
        } catch {
            throw error
        }
    }
}
