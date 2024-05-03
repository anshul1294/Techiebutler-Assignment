//
// Entity.swift
// Cityflo
//
// Created by Anshul Gupta on 03/05/24.
// Copyright © Cityflo. All rights reserved.
//


import Foundation

struct Post: Codable {
    let userID: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
}
