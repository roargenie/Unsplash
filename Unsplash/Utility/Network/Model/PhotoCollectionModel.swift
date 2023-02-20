//
//  PhotoCollectionModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/20.
//

import Foundation

struct PhotoCollection: Codable {
    let id: String
    let width, height: Int
    let urls: Urls
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case width, height
        case urls
        case user
    }
}
