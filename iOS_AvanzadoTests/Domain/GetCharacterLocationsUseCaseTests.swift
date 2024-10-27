//
//  GetCharacterLocationsUseCaseTests.swift
//  iOS_AvanzadoTests
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

@testable import iOS_Avanzado
import XCTest

final class GetCharacterLocationsUseCaseTests: XCTestCase {
    
    var sut: GetCharacterLocationsUseCase!
    var storeDataProvider: StoreDataProvider!
    let characterId = "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        storeDataProvider = StoreDataProvider(.inMemory)
        sut = GetCharacterLocationsUseCase(storeDataProvider)
    }

    override func tearDownWithError() throws {
        storeDataProvider = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_execute_APIRequestSuccess() {

        let expectation = self.expectation(description: "UseCaseSuccess")
        
        do{
            try storeDataProvider.clearBBDD()
            try storeDataProvider.addCharacters(characters: DataMock.mockCharacters())
        }
        catch
        {
            XCTFail()
        }
        
        var mockedLocations : [APILocation]?
        var resultLocations : [DBLocation]?
        var mockedAPISession : APISessionMock!
        do{
            mockedLocations = try DataMock.mockLocations()
        }
        catch{
            XCTFail()
        }
        
        do {
            let encodedLocations = try JSONEncoder().encode(mockedLocations)
            mockedAPISession = APISessionMock{ _ in .success(encodedLocations) }
            APISession.shared = mockedAPISession
            sut.execute(characterId) { result in
                guard case .success(let locations) = result else {
                    XCTFail()
                    return
                }
                resultLocations = locations
                expectation.fulfill()
            }
            
        }
        catch {
            XCTFail()
        }
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(resultLocations)
        XCTAssertEqual(resultLocations?.count, mockedLocations?.count)
        XCTAssertTrue(mockedAPISession.hasRequestSession)
        XCTAssertEqual(resultLocations?.count, storeDataProvider.fetchCharacterLocations(characterId).count)
    }
    
    func test_execute_CoreDataFound() {

        let expectation = self.expectation(description: "UseCaseSuccess")
        
        do{
            try storeDataProvider.clearBBDD()
            try storeDataProvider.addCharacters(characters: DataMock.mockCharacters())
        }
        catch
        {
            XCTFail()
        }
        
        var mockedLocations : [APILocation]!
        var resultLocations : [DBLocation]?
        var mockedAPISession : APISessionMock!
        do{
            mockedLocations = try DataMock.mockLocations()
        }
        catch{
            XCTFail()
        }
        
        do {
            storeDataProvider.addLocations(locations: mockedLocations)
            
            let encodedLocations = try JSONEncoder().encode(mockedLocations)
            mockedAPISession = APISessionMock{ _ in .success(encodedLocations) }
            APISession.shared = mockedAPISession
            sut.execute(characterId) { result in
                guard case .success(let locations) = result else {
                    XCTFail()
                    return
                }
                resultLocations = locations
                expectation.fulfill()
            }
            
        }
        catch {
            XCTFail()
        }
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(resultLocations)
        XCTAssertEqual(resultLocations?.count, mockedLocations.count)
        XCTAssertFalse(mockedAPISession.hasRequestSession)
        XCTAssertEqual(resultLocations?.count, storeDataProvider.fetchCharacterLocations(characterId).count)
    }
    
    func test_execute_APIRequestFailure() {
        
        let expectation = self.expectation(description: "UseCaseFailure")
        var mockedAPISession : APISessionMock!
        
        do{
            try storeDataProvider.clearBBDD()
            try storeDataProvider.addCharacters(characters: DataMock.mockCharacters())
        }
        catch
        {
            XCTFail()
        }
        
        mockedAPISession = APISessionMock{ _ in .failure(GetAllCharactersUseCaseError(reason: "Use Case Failed")) }
        APISession.shared = mockedAPISession
        sut.execute(characterId) { result in
            guard case .failure = result else {
                XCTFail()
                return
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(mockedAPISession.hasRequestSession)
    }
}

