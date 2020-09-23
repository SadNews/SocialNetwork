//
//  NetworkService.swift
//  CrabPeople
//
//  Created by Андрей Ушаков on 20.09.2020.
//

import Foundation

protocol Networking {
    func request(path: String, cursor: String?, completion: @escaping (Data?, Error?) -> Void)
    
}
final class NetworkService: Networking {
    
    func request(path: String, cursor: String?, completion: @escaping (Data?, Error?) -> Void) {
        let url = self.url(cursor: cursor)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    func url( cursor: String?) -> URL {
        var components = URLComponents()
        var params = ["orderBy": Constants.orderBy]
        params["cursor"] = cursor
        components.scheme = API.scheme
        components.host = API.host
        components.port = API.port
        components.path = API.newsFeed
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
