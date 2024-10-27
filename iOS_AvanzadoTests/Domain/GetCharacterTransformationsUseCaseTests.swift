//
//  GetCharacterTransformationsUseCaseTests.swift
//  iOS_AvanzadoTests
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//


@testable import iOS_Avanzado
import XCTest

final class GetCharacterTransformationsUseCaseTests: XCTestCase {
    
    var sut: GetCharacterTransformationsUseCase!
    var storeDataProvider: StoreDataProvider!
    let characterId = "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        storeDataProvider = StoreDataProvider(.inMemory)
        sut = GetCharacterTransformationsUseCase(storeDataProvider)
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
        
        var mockedTransformations : [APITransformation]!
        var resultTransformations : [DBTransformation]?
        var mockedAPISession : APISessionMock!
        do{
            mockedTransformations = try DataMock.mockTransformations()
        }
        catch{
            XCTFail()
        }
        
        do {
            let encodedTransformations = try JSONEncoder().encode(mockedTransformations)
            mockedAPISession = APISessionMock{ _ in .success(encodedTransformations) }
            APISession.shared = mockedAPISession
            sut.execute(characterId) { result in
                guard case .success(let transformations) = result else {
                    XCTFail()
                    return
                }
                resultTransformations = transformations
                expectation.fulfill()
            }
            
        }
        catch {
            XCTFail()
        }
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(resultTransformations)
        XCTAssertEqual(resultTransformations?.count, mockedTransformations?.count)
        XCTAssertTrue(mockedAPISession.hasRequestSession)
        XCTAssertEqual(resultTransformations?.count, storeDataProvider.fetchCharacterTransformations(characterId).count)
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
        
        var mockedTransformations : [APITransformation]!
        var resultTransformations : [DBTransformation]?
        var mockedAPISession : APISessionMock!
        do{
            mockedTransformations = try DataMock.mockTransformations()
        }
        catch{
            XCTFail()
        }
        
        do {
            storeDataProvider.addTransformations(transformations: mockedTransformations)
            
            let encodedTransformations = try JSONEncoder().encode(mockedTransformations)
            mockedAPISession = APISessionMock{ _ in .success(encodedTransformations) }
            APISession.shared = mockedAPISession
            sut.execute(characterId) { result in
                guard case .success(let transformations) = result else {
                    XCTFail()
                    return
                }
                resultTransformations = transformations
                expectation.fulfill()
            }
            
        }
        catch {
            XCTFail()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(resultTransformations)
        XCTAssertEqual(resultTransformations?.count, mockedTransformations.count)
        XCTAssertFalse(mockedAPISession.hasRequestSession)
        XCTAssertEqual(resultTransformations?.count, storeDataProvider.fetchCharacterTransformations(characterId).count)
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
        
        mockedAPISession = APISessionMock{ _ in .failure(GetCharacterTransformationsUseCaseError(reason: "Use Case Failed")) }
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

