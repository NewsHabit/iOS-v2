//
//  NewsAPIProtocol.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 9/12/24.
//

import Foundation

import Alamofire

public protocol NewsAPIProtocol {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    )
}
