//
// PostViewModel.swift
// Cityflo
//
// Created by Anshul Gupta on 03/05/24.
// Copyright © Cityflo. All rights reserved.
//


import Foundation
class PostViewModel {
    var posts: [Post] = [] {
        didSet {
            delegate?.itemsDidChange()
        }
    }
    
    var pageNumber: Int = 1
    var limit: Int = 10
    var fetchedPages: Set<Int> = []
    var hasMoreData: Bool = true
    
    var isFetchingData: Bool = false
    weak var delegate: PostViewModelDelegate?
    
    weak var errorDelegate: PostViewModelErrorDelegate?
        
    let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }

    func fetchPosts() {
        guard !isFetchingData else { return }
        guard !fetchedPages.contains(pageNumber) else { return }
        isFetchingData = true
        let params = ["_page": pageNumber, "_limit": limit]
        postRepository.fetchPosts(param: params) { [weak self] result in
            guard let self = self else { return }
            
            defer {
                self.isFetchingData = false
            }
            switch result {
            case .success(let fetchedPosts):
                let newPosts = fetchedPosts.filter { fetchedPost in
                    !self.posts.contains(where: { $0.id == fetchedPost.id })
                }
                self.posts.append(contentsOf: newPosts)
                self.fetchedPages.insert(self.pageNumber)
                self.hasMoreData = !fetchedPosts.isEmpty
            case .failure(let failure):
                self.errorDelegate?.showError(error: failure.localizedDescription)
            }
        }
    }
    
    func updatePageNumber() {
        if hasMoreData {
            pageNumber += 1
        }
    }
}

protocol PostViewModelDelegate: AnyObject {
    func itemsDidChange()
}

protocol PostViewModelErrorDelegate: AnyObject {
    func showError(error: String)
}
