//
//  WeatherService.swift
//  mobile-universal-architecture-swift
//
//  Created by Victor Carreras on 9/5/22.
//

import Foundation

class BrastlewarkService {
    
    let networkService: NetworkService
    
    init(service: NetworkService) {
        networkService = service
    }
    
    func getVillagersInBrastlewark() async throws -> BrastlewarkModel {
        let url = UrlService.villagersInBrastlewark()
        return try await getVillagersFromURL(url: url)
    }
    
    private func getVillagersFromURL(url: URL) async throws -> BrastlewarkModel {
        let (data, _) = try await networkService.performGetRequest(url: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let villagers = try decoder.decode(BrastlewarkModel.self, from: data)
        return villagers
    }
}
