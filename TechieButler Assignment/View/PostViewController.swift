//
// PostViewController.swift
// Cityflo
//
// Created by Anshul Gupta on 03/05/24.
// Copyright © Cityflo. All rights reserved.
//


import UIKit

class PostDetailsViewController: UIViewController {
    let post: Post
    
    let userIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        configureUI()
    }
    
    private func configureUI() {
        
        view.addSubview(userIdLabel)
        view.addSubview(idLabel)
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        
        if let userID = post.userID, let id = post.id, let title = post.title, let body = post.body {
            userIdLabel.text = "User ID: \(userID)"
            idLabel.text = "ID: \(id)"
            titleLabel.text = "Title: \(title)"
            bodyLabel.text = "Body: \(body)"
        }
        
        
        NSLayoutConstraint.activate([
            userIdLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userIdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            idLabel.topAnchor.constraint(equalTo: userIdLabel.bottomAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

}
