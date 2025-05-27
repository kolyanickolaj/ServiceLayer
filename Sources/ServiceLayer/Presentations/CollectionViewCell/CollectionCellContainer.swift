//
//  CollectionViewCell.swift
//  Tonywin
//
//  Created by Andrey on 6/30/23.
//

import UIKit

public final class CollectionCellContainer<View: UIView>: UICollectionViewCell, Configurable where View: Configurable {

    private var view: View?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Reusable
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        (view as? Reusable)?.prepareForReuse()
    }

    // MARK: - Configurable
    
    public typealias Model = View.Model

    public func configure(_ model: View.Model) {
        view?.configure(model)
    }
}

private extension CollectionCellContainer {

    func setup() {
        let view = View()
        self.view = view
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
