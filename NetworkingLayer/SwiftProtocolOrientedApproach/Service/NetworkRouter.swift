//
//  NetworkRouter.swift
//  NetworkingLayer
//
//  Created by Tricon Infotech on 12/04/19.
//  Copyright © 2019 Tricon Infotech. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class{
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
