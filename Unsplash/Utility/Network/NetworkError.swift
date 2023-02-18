//
//  NetworkError.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/18.
//

import Foundation

@frozen
enum APIError: Int, Error {
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case notFound = 404
    case serverErrorCase1 = 500
    case serverErrorCase2 = 503
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest: return "The request was unacceptable, often due to missing a required parameter"
        case .unAuthorized: return "Invalid Access Token"
        case .forbidden: return "Missing permissions to perform request"
        case .notFound: return "The requested resource doesn’t exist"
        case .serverErrorCase1: return "Server Error"
        case .serverErrorCase2: return "Server Error"
        }
    }
}
