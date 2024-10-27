//
//  GetCaracterUseCaseTests.swift
//  iOS_AvanzadoTests
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

@testable import iOS_Avanzado
import XCTest

final class GetCharacterUseCaseTests: XCTestCase {
    
    var sut: GetCharacterUseCase!
    var storeDataProvider: StoreDataProvider!
    let characterId = "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"

    override func setUpWithError() throws {
        try super.setUpWithError()
        storeDataProvider = StoreDataProvider(.inMemory)
        sut = GetCharacterUseCase(storeDataProvider)
    }
    
    override func tearDownWithError() throws {
        storeDataProvider = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_execute_FoundCharacter() {
        
        let expectation = self.expectation(description: "UseCaseSuccess")

        do{
            try storeDataProvider.clearBBDD()
            try storeDataProvider.addCharacters(characters: DataMock.mockCharacters())
        }
        catch
        {
            XCTFail()
        }
        
        var resultCharacter: DBCharacter?
 
        sut.execute(characterId) { result in
            guard case .success(let character) = result else {
                XCTFail()
                return
            }
            resultCharacter = character
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNotNil(resultCharacter)
        XCTAssertEqual(resultCharacter?.id, storeDataProvider.fetchCharacter(characterId)?.id)
        XCTAssertEqual(resultCharacter?.name, storeDataProvider.fetchCharacter(characterId)?.name)
        XCTAssertEqual(resultCharacter?.description, storeDataProvider.fetchCharacter(characterId)?.detail)
        XCTAssertEqual(resultCharacter?.favorite, storeDataProvider.fetchCharacter(characterId)?.favorite)
        XCTAssertEqual(resultCharacter?.photo, storeDataProvider.fetchCharacter(characterId)?.photo)
    }
    
    func test_execute_NotFoundCharacter() {
        
        let expectation = self.expectation(description: "UseCaseSuccess")

        do{
            try storeDataProvider.clearBBDD()
            try storeDataProvider.addCharacters(characters: DataMock.mockCharacters())
        }
        catch
        {
            XCTFail()
        }
        
        var resultCharacter: DBCharacter?
 
        sut.execute("SaMataoPaco") { result in
            guard case .failure = result else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(resultCharacter)
    }
}
