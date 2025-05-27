//
//  UICollectionView+Cells.swift
//  Tonywin
//
//  Created by Andrey on 6/30/23.
//

import Foundation
import UIKit

extension UICollectionView {

    public func register<T: UICollectionViewCell>(_ type: T.Type) {
        let identifierName = String(describing: type)
        register(T.self, forCellWithReuseIdentifier: identifierName)
    }

    public func register<T: UICollectionReusableView>(_ view: T.Type, kind: String) {
        let nibName = String(describing: view)
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: nibName)
    }

    public func dequeue<T: UICollectionViewCell>(_ cell: T.Type, at indexPath: IndexPath) -> T {
        let identifierName = String(describing: cell)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifierName, for: indexPath) as? T else {
            assert(false, "could not deque cell with for \(T.self) with id: \(identifierName)")
            return T()
        }
        return cell
    }

    public func dequeue<T: UICollectionReusableView>(_ cell: T.Type, kind: String, at indexPath: IndexPath) -> T {
        let cellID = String(describing: cell)
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellID, for: indexPath) as? T else {
            assert(false, "could not deque cell with for \(T.self) with id: \(kind)")
            return T()
        }
        return cell
    }
}
