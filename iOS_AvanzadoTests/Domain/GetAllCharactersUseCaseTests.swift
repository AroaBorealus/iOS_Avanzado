//
//  GetAllCharactersUseCaseTests.swift
//  iOS_AvanzadoTests
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

@testable import iOS_Avanzado
import XCTest

final class GetAllCharactersUseCaseTests: XCTestCase {
    
    var sut: GetAllCharactersUseCase!
    var storeDataProvider: StoreDataProvider!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        storeDataProvider = StoreDataProvider(.inMemory)
        sut = GetAllCharactersUseCase(storeDataProvider)
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
        }
        catch
        {
            return
        }
        
        var mockedCharacters : [APICharacter]?
        var resultCharacters : [DBCharacter]?
        var mockedAPISession : APISessionMock!
        do{
            mockedCharacters = try DataMock.mockCharacters()
        }
        catch{
            return
        }
        
        do {
            let encodedCharacters = try JSONEncoder().encode(mockedCharacters)
            mockedAPISession = APISessionMock{ _ in .success(encodedCharacters) }
            APISession.shared = mockedAPISession
            sut.execute() { result in
                guard case .success(let characters) = result else {
                    return
                }
                resultCharacters = characters
                expectation.fulfill()
            }
            
        }
        catch {
            return
        }
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(resultCharacters)
        XCTAssertEqual(resultCharacters?.count, mockedCharacters?.count)
        XCTAssertTrue(mockedAPISession.hasRequestSession)
        XCTAssertEqual(resultCharacters?.count, storeDataProvider.fetchAllCharacters().count)
    }
    
    func test_execute_CoreDataFound() {

        let expectation = self.expectation(description: "UseCaseSuccess")
        
        do{
            try storeDataProvider.clearBBDD()
        }
        catch
        {
            return
        }
        
        var mockedCharacters : [APICharacter]!
        var resultCharacters : [DBCharacter]?
        var mockedAPISession : APISessionMock!
        do{
            mockedCharacters = try DataMock.mockCharacters()
        }
        catch{
            return
        }
        
        do {
            storeDataProvider.addCharacters(characters: mockedCharacters)
            
            let encodedCharacters = try JSONEncoder().encode(mockedCharacters)
            mockedAPISession = APISessionMock{ _ in .success(encodedCharacters) }
            APISession.shared = mockedAPISession
            sut.execute() { result in
                guard case .success(let characters) = result else {
                    return
                }
                resultCharacters = characters
                expectation.fulfill()
            }
            
        }
        catch {
            return
        }
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(resultCharacters)
        XCTAssertEqual(resultCharacters?.count, mockedCharacters.count)
        XCTAssertFalse(mockedAPISession.hasRequestSession)
        XCTAssertEqual(resultCharacters?.count, storeDataProvider.fetchAllCharacters().count)
    }
    
    func test_execute_APIRequestFailure() {
        
        let expectation = self.expectation(description: "UseCaseFailure")
        var mockedAPISession : APISessionMock!
        
        do{
            try storeDataProvider.clearBBDD()
        }
        catch
        {
            return
        }
        
        mockedAPISession = APISessionMock{ _ in .failure(GetAllCharactersUseCaseError(reason: "Use Case Failed")) }
        APISession.shared = mockedAPISession
        sut.execute() { result in
            guard case .failure = result else {
                return
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(mockedAPISession.hasRequestSession)
    }
}
