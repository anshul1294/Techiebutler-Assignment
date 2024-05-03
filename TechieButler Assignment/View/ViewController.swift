//
// ViewController.swift
// Cityflo
//
// Created by Anshul Gupta on 03/05/24.
// Copyright © Cityflo. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 100
        view.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        return view
    }()
    
    var viewModel = PostViewModel(postRepository: PostRepositoryImplementation())

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        viewModel.delegate = self
        viewModel.fetchPosts()
        addTableView()
    }
    
    func addTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell
        cell?.layoutViews(post: viewModel.posts[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.row]
        let postVC = PostDetailsViewController(post: post)
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 && !viewModel.isFetchingData{
            viewModel.updatePageNumber()
            viewModel.fetchPosts()
        }
    }
}

extension ViewController: PostViewModelDelegate {
    func itemsDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}


extension ViewController: PostViewModelErrorDelegate {
    func showError(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
