//
//  UseCase.swift
//  DomainNewsInterface
//
//  Created by 지연 on 9/12/24.
//

import Combine
import Foundation

public protocol UseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(_ input: Input) -> AnyPublisher<Output, Error>
}
