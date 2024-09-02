//
//  UITableView+Reusable.swift
//  SharedUtil
//
//  Created by 지연 on 8/29/24.
//

import UIKit

extension UITableView {
    public final func register<Cell: UITableViewCell>(cellType: Cell.Type) where Cell: Reusable {
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    public final func dequeueReusableCell<Cell: UITableViewCell>(
        for indexPath: IndexPath,
        cellType: Cell.Type = Cell.self
    ) -> Cell where Cell: Reusable {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        return cell
    }
}
