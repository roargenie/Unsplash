//
//  APIManager.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    typealias requestCompletion<T> = (Result<T?, APIError>) -> Void
    
    func requestData<T: Decodable>(_ object: T.Type = T.self,
                                   router: UnsplashRouter,
                                   completion: @escaping requestCompletion<T>) {
        AF.request(router)
            .responseDecodable(of: object) { response in
                guard let statusCode = response.response?.statusCode else { return }
                print("🔵", statusCode)
                switch response.result {
                case .success(let value):
                    completion(.success(value))
//                    print(value)
                case .failure(_):
                    guard let error = APIError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
        
    }
    
}
