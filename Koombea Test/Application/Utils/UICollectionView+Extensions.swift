//
//  UICollectionView+Extensions.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 17/01/21.
//

import UIKit

extension UICollectionView {
    
    public func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let bundle = Bundle(for: T.self)
        register(UINib(nibName: String(describing: cellClass), bundle: bundle), forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    public func registerSupplementaryView<T: UICollectionReusableView>(_ viewClass: T.Type, for kind: String) {
        let bundle = Bundle(for: T.self)
        register(UINib(nibName: String(describing: viewClass), bundle: bundle),
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: String(describing: viewClass))
    }
    
    public func dequeueCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    public func dequeueSupplementaryView<T: UICollectionReusableView>(for kind: String,
                                                               at indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            return T()
        }
        return view
    }
}

