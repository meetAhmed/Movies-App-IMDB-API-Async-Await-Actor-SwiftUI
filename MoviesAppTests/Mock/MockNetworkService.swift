//
//  MockNetworkService.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 18/08/2025.
//

import Foundation
@testable import MoviesApp

class MockNetworkService: MoviesNetworkingService {
    var data: Data?
    var error: Error?
    
    func fetchData(api: APIConstructor) async throws -> Data {
        if let error = error {
            throw error
        }
        
        guard let data else {
            throw MoviesNetworkingServiceError.invalidData
        }
        
        return data
    }
}
