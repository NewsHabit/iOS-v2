//
//  UITextField+Combine.swift
//  SharedUtil
//
//  Created by 지연 on 9/5/24.
//

import Combine
import UIKit

extension UITextField {
    public var textPublisher: AnyPublisher<String, Never> {
        Publishers.Merge(
            publisher(for: \.text).compactMap { $0 },
            NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
                .compactMap { ($0.object as? UITextField)?.text }
        )
        .eraseToAnyPublisher()
    }
}
