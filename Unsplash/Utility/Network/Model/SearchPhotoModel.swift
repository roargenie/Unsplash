//
//  SearchPhotoModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/22.
//

import Foundation

// MARK: - SearchPhoto

struct SearchPhoto: Codable, Hashable {
    let total, totalPages: Int
    let results: [SearchResult]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - SearchResult

struct SearchResult: Codable, Hashable {
    let id: String
    let user: User
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case user
    }
}
