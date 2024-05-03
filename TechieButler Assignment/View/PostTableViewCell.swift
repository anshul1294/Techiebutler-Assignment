//
// PostTableViewCell.swift
// Cityflo
//
// Created by Anshul Gupta on 03/05/24.
// Copyright © Cityflo. All rights reserved.
//


import UIKit

class PostTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        label.textColor = UIColor.black
        return label
    }()
    
    
    static let reuseIdentifier = String(describing: PostTableViewCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews(post: Post) {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(idLabel)
        
        
        titleLabel.text = post.title
        if let id = post.id {
            let idText = "\(id)"
            idLabel.text =  idText
        }
    
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            idLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            idLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            idLabel.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}
