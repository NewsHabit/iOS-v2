//
//  NewsAPIService.swift
//  CoreNetwork
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

import CoreNetworkInterface

import Alamofire

public final class NewsAPIService: NewsAPIProtocol {
    private let baseURL: String
    private let session: Session
    
    public init(baseURL: String, session: Session = .default) {
        self.baseURL = baseURL
        self.session = session
    }
    
    public func execute<E: EndpointSpecifiable>(_ endpoint: E) 
    -> AnyPublisher<E.Response, Error> {
        let url = baseURL + endpoint.path
        
        return Future { [weak self] promise in
            guard let self = self else {
                promise(.failure(NSError(
                    domain: "NewsAPIService",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Self is nil"])
                ))
                return
            }
            
            self.session.request(url,
                                 method: endpoint.method,
                                 parameters: endpoint.parameters,
                                 encoding: endpoint.encoding)
            .validate()
            .responseDecodable(of: E.Response.self) { response in
                switch response.result {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
