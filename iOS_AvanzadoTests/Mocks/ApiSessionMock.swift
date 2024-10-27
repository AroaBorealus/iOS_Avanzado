//
//  ApiSessionMock.swift
//  iOS_AvanzadoTests
//
//  Created by Aroa Miguel Garcia on 27/10/24.
//

@testable import iOS_Avanzado
import XCTest


final class APISessionMock: APISessionContract {
    let mockResponse: ((any APIRequest) -> Result<Data, any Error>)
    var hasRequestSession = false
    var request: (any APIRequest)?
    
    init(mockResponse: @escaping (any APIRequest) -> Result<Data, any Error>) {
        self.mockResponse = mockResponse
    }
    
    func request<Request: APIRequest>(apiRequest: Request, completion: @escaping (Result<Data, any Error>) -> Void) {
        completion(mockResponse(apiRequest))
        request = apiRequest
        hasRequestSession = true
    }
}

final class SessionDataSourceMock: SessionDataSourcesContract {
    
    private var sessionValue: String?
    
    init(_ sessionValue: String? = nil) {
        self.sessionValue = sessionValue
    }
    
    func setSession(_ session: Data) {
        sessionValue = String(decoding: session, as: UTF8.self)
    }
    
    func getSession() -> String? {
        return sessionValue
    }
    
    func hasSession() -> Bool {
        return sessionValue != nil
    }
    
    func deleteSession() {
        sessionValue = nil
    }
    
}
