//
//  NetworkService.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 23/4/22.
//

import Foundation

protocol NetworkService {
    func performGetRequest(url: URL) async throws -> (Data, URLResponse)
    func performPostRequest(url: URL) async  throws -> (Data, URLResponse)
    func performPutRequest(url: URL) async throws -> (Data, URLResponse)
    func performDeleteRequest(url: URL) async throws -> (Data, URLResponse)
}
