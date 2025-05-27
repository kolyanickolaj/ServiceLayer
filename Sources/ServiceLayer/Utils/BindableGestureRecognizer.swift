//
//  BindableGestureRecognizer.swift
//  Tonywin
//
//  Created by Andrey on 7/2/23.
//

import UIKit

final class BindableGestureRecognizer: UILongPressGestureRecognizer {
    private let action: (UIGestureRecognizer) -> Void

    init(_ action: @escaping (UIGestureRecognizer) -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action(self)
    }
}
