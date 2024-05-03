//
// PostRepository.swift
// Cityflo
//
// Created by Anshul Gupta on 03/05/24.
// Copyright © Cityflo. All rights reserved.
//


import Foundation


protocol PostRepository {
    func fetchPosts(param: [String: Any]?,completion: @escaping (Result<[Post], NetworkError>) -> Void)
}

class PostRepositoryImplementation: PostRepository {
    func fetchPosts(param: [String: Any]? = nil,completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        NetworkHelper.shared.fetchPostFromNetwork(from: NetworkHelper.Endpoint.getPostData, parameters: param) { result in
            switch result {
            case .success(let posts):
                completion(.success(posts))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
