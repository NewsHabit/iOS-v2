//
//  EndpointSpecifiable.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 9/12/24.
//

import Foundation

import Alamofire

public protocol EndpointSpecifiable {
    associatedtype Response: Decodable
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var encoding: URLEncoding { get }
}
