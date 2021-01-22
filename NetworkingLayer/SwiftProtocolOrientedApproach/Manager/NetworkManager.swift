//
//  NetworkManager.swift
//  NetworkingLayer
//
//  Created by Tricon Infotech on 12/04/19.
//  Copyright © 2019 Tricon Infotech. All rights reserved.
//

import Foundation

struct NetworkManager{
    static let environment: NetworkEnvironment = .staging
    static let MovieAPIKey = "movie_key"
    private let router = Router<MovieApi>()
    
    func getNewMovies(page: Int, completion: @escaping (_ movie: [Employee]?,_ error: String?) -> ()){
        router.request(.getEmployees){ data, response, error in
            if error != nil{
                completion(nil, "please check your internet")
            }
            if let response = response as? HTTPURLResponse{
                let result = handleNetworkResponse(response)
                switch result{
                case .success:
                    guard let responseData = data else {
                        completion(nil,NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([Employee].self, from: responseData)
                        completion(apiResponse, nil)
                        print(data)
                    }catch{
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}

enum NetworkResponse: String{
    case success
    case authenticationError = "authenticationError"
    case failed = "failed"
    case badRequest = "badRequest"
    case outDated = "outDated"
    case noData = "noData"
    case unableToDecode = "unableToDecode"
}

enum Result<String>{
    case success
    case failure(String)
}

fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
    switch response.statusCode{
    case 200...299:
        return .success
    case 401...499:
        return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599:
        return .failure(NetworkResponse.badRequest.rawValue)
    case 600:
        return .failure(NetworkResponse.outDated.rawValue)
    default:
        return .failure(NetworkResponse.failed.rawValue)
    }
}


