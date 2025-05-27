//
//  TableCellContainer.swift
//  Tonywin
//
//  Created by Andrey on 6/30/23.
//

import UIKit

public protocol CellView: UIView {
    var selectionStyle: UITableViewCell.SelectionStyle { get }
}

extension UIView: CellView {
    @objc public var selectionStyle: UITableViewCell.SelectionStyle { .none }
}

public final class TableCellContainer<View: CellView>: UITableViewCell, Configurable where View: Configurable {

    private var view: View?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurable

    public typealias Model = View.Model
    
    public func configure(_ model: Model) {
        view?.configure(model)
    }
}

private extension TableCellContainer {

    func setup() {
        let view = View()
        self.view = view
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        selectionStyle = view.selectionStyle
        backgroundColor = .clear
    }
}
