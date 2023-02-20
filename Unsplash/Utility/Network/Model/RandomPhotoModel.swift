//
//  RandomPhotoModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation



//MARK: - RandomPhoto

struct RandomPhoto: Codable, RandomPhotoCollectionType {
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

// MARK: - Urls

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User

struct User: Codable {
    let id: String
    let username, name: String
    let profileImage: ProfileImage
    let totalCollections, totalLikes, totalPhotos: Int

    enum CodingKeys: String, CodingKey {
        case id
        case username, name
        case profileImage = "profile_image"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
    }
}

// MARK: - ProfileImage

struct ProfileImage: Codable {
    let small, medium, large: String
}
