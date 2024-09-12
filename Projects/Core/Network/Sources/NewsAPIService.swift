//
//  NewsAPIService.swift
//  CoreNetwork
//
//  Created by 지연 on 9/12/24.
//

import Foundation

import CoreNetworkInterface

import Alamofire

public final class NewsAPIService: NewsAPIProtocol {
    private let serverIP = "https://newshabit.org"
    
    private init() {}
    
    public func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            serverIP + endpoint,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
