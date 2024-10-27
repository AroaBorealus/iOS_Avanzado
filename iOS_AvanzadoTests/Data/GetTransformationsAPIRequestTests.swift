//
//  GetTransformationsAPIRequestTests.swift
//  iOS_AvanzadoTests
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

@testable import iOS_Avanzado
import XCTest

final class GetTransformationsAPIRequestTests: XCTestCase {
    var sut: GetTransformationsAPIRequest!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = GetTransformationsAPIRequest(characterId: "Lorem")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func test_getRequest_ValidURL() {
        
        var generatedRequest: URLRequest!
        
        do{
            generatedRequest = try sut.getRequest()
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssertEqual(generatedRequest.httpMethod, "POST")
        XCTAssertEqual(generatedRequest.url?.absoluteString, "https://dragonball.keepcoding.education/api/heros/tranformations")
        
        let testBody = try! JSONEncoder().encode(GetTransformationsAPIRequest.RequestEntity(id: "Lorem"))
        XCTAssertEqual(generatedRequest.httpBody, testBody)
    }
}

