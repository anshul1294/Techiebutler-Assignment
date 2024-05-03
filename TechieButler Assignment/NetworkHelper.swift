//
// NetworkHelper.swift
// Cityflo
//
// Created by Anshul Gupta on 03/05/24.
// Copyright © Cityflo. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case other(Error)
}

class NetworkHelper {
    
    static public let shared = NetworkHelper()
    private let session: URLSession
    
    private init(){
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 5
        session = URLSession(configuration: config)
    }
    
    struct Endpoint {
        static let getPostData = "https://jsonplaceholder.typicode.com/posts"
    }
   
    func fetchPostFromNetwork(from endpoint: String, parameters: [String: Any]? = nil, completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        guard var urlComponents = URLComponents(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        if let parameters = parameters {
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        getData(from: urlRequest, completion: completion)
    }
}


extension NetworkHelper {
    
    func getData<T: Decodable>(from request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let string = try JSONSerialization.jsonObject(with: data)
                print(string)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }
}
