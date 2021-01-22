//
//  Encoding.swift
//  NetworkingLayer
//
//  Created by Tricon Infotech on 12/04/19.
//  Copyright © 2019 Tricon Infotech. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL {get}
    var basePath: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask {get}
    var headers: HTTPHeaders? {get}
}

public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum HTTPTask{
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
