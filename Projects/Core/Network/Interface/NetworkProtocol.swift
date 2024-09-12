//
//  NetworkProtocol.swift
//  CoreNetworkInterface
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

public protocol NetworkProtocol {
    func execute<E: EndpointSpecifiable>(_ endpoint: E) -> AnyPublisher<E.Response, Error>
}
