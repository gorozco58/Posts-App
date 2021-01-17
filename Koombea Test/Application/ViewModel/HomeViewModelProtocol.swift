//
//  HomeViewModelProtocol.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import UIKit
import RxSwift

protocol HomeViewModelProtocol: HomeViewControllerDataSourceProvider {
    var onAction: Observable<HomeViewModelAction> { get }
    
    func fetchPosts()
}

enum HomeViewModelAction {
    case reloadData
    case showImage(UIImage)
}
