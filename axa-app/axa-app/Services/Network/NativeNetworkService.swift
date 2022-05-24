//
//  NativeNetworkService.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 9/5/22.
//

import Foundation

class NativeNetworkService: NetworkService {
    func performGetRequest(url: URL) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(from: url)
    }
    
    func performPostRequest(url: URL) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(from: url)
    }
    
    func performPutRequest(url: URL) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(from: url)
    }
    
    func performDeleteRequest(url: URL) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(from: url)
    }
}
