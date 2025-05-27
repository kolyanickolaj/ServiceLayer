//
//  UITabbleView+Cells.swift
//  Tonywin
//
//  Created by Andrey on 6/30/23.
//

import UIKit

extension UITableView {

    public func register<T: UITableViewCell>(cell: T.Type) {
        let identifierName = String(describing: cell)
        register(T.self, forCellReuseIdentifier: identifierName)
    }

    public func dequeue<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        let identifierName = String(describing: cell)
        guard let cell = dequeueReusableCell(withIdentifier: identifierName, for: indexPath) as? T else {
            assert(false, "could not deque cell with for \(T.self) with id: \(identifierName)")
            return T()
        }
        return cell
    }
}
