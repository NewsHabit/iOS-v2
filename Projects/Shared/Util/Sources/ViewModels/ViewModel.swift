//
//  ViewModel.swift
//  SharedUtil
//
//  Created by 지연 on 9/4/24.
//

import Combine
import Foundation

public protocol ViewModel {
    associatedtype Action
    
    associatedtype State
    
    var cancellables: Set<AnyCancellable> { get set }
    
    func send(_ action: Action)
}
