//
//  NetworkDataFetcher.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 20.09.2020.
//

import Foundation

protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (Model?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(nextBatchFrom: String?, response: @escaping (Model?) -> Void) {
        networking.request(path: API.newsFeed, cursor: nextBatchFrom) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: Model.self, from: data)
            response(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
