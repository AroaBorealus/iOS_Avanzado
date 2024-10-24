//
//  SessionDataSources.swift
//  iOS_Avanzado
//
//  Created by Aroa Miguel Garcia on 17/10/24.
//

//import Foundation
//
//protocol SessionDataSourcesContract {
//    func getSession() -> Data?
//    func setSession(_ session: Data)
//}
//
//final class SessionDataSources: SessionDataSourcesContract {
//    private static var token: Data?
//    
//    func getSession() -> Data?{
//        return SessionDataSources.token
//    }
//    
//    func setSession(_ session: Data) {
//        SessionDataSources.token = session
//    }
//}





import Foundation
import KeychainSwift

protocol SessionDataSourcesContract {
    func getSession() -> String?
    func hasToken() -> Bool
    func setSession(_ session: Data)
    func deleteSession()
}

final class SessionDataSources: SessionDataSourcesContract {
    
    private let kToken = "kToken"
    private let keychain  = KeychainSwift()
    
    static let shared: SessionDataSources = .init()
    
    func getSession() -> String?{
        keychain.get(kToken)
    }
    
    func hasToken() -> Bool{
        guard let tokenExists = keychain.get("kToken") else {
            return false
        }
        return true
    }
    
    func setSession(_ session: Data) {
        keychain.set(String(decoding: session, as: UTF8.self), forKey: kToken)
    }
    
    func deleteSession() {
        keychain.delete(kToken)
        
    }
}
