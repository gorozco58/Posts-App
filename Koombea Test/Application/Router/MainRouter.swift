//
//  MainRouter.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import UIKit

class MainRouter: MainRouterProtocol {
    var baseController = UINavigationController()
    
    func performTransition(transition: MainTransition, completion: (() -> Void)?) {
        switch transition {
        case .showHome:
            let viewModel = HomeViewModel()
            let homeViewController = HomeViewController(viewModel: viewModel, router: self)
            let navigationController = UINavigationController(rootViewController: homeViewController)
            navigationController.navigationBar.isTranslucent = false
            baseController = navigationController
            
        case .showImageDetail(let image):
            let viewController = DetailImageViewController(image: image)
            baseController.present(viewController, animated: true, completion: completion)
        }
    }
}
