//
//  MainRouterProtocol.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import UIKit

protocol MainRouterProtocol {
    var baseController: UINavigationController { get }
    
    func performTransition(transition: MainTransition, completion: (() -> Void)?)
}

enum MainTransition {
    case showHome
    case showImageDetail(UIImage)
}
