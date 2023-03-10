//
//  UnsplashRouter.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation
import Alamofire

enum UnsplashRouter {
    case randomPhoto
    case photoCollection
    case searchPhoto(_ query: String)
    case searchUser
}

extension UnsplashRouter: URLRequestConvertible {
    
    var baseURL: URL {
        return URL(string: EndPoint.baseURL)!
    }
    
    var path: String {
        switch self {
        case .randomPhoto: return "photos/random"
        case .photoCollection: return "photos"
        case .searchPhoto: return "search/photos"
        case .searchUser: return ""
        }
    }
    
    var headers: [String: String] {
        return ["Authorization": APIKey.authorization]
    }
    
    var method: HTTPMethod {
        switch self {
        case .randomPhoto, .photoCollection, .searchPhoto, .searchUser:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .randomPhoto:
            return ["count": "30"]
        case .photoCollection:
            return ["": ""]
        case .searchPhoto(let query):
            return ["query": query]
//        case .searchUser:
//            return ["": ""]
        default:
            return ["": ""]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)
        
        switch self {
        case .randomPhoto:
            request = try URLEncoding().encode(request, with: parameters)
        case .searchPhoto:
            request = try URLEncoding().encode(request, with: parameters)
        default:
            return request
        }
        
        return request
    }
    
    
}
