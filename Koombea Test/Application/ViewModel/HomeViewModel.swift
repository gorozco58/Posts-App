//
//  HomeViewModel.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import Foundation
import RxSwift

class HomeViewModel {
    struct Dependencies {
        var getPostsUseCase: GetPostsUseCase = GetPostsUseCaseAdapter()
    }
    
    private let dependencies: Dependencies
    private let onActionSubject = PublishSubject<HomeViewModelAction>()
    private let disposeBag = DisposeBag()
    private(set) var posts: [Post] = []
    
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }
}

//MARK: - HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    
    var onAction: Observable<HomeViewModelAction> {
        return onActionSubject.asObservable()
    }
    
    func fetchPosts() {
        dependencies
            .getPostsUseCase
            .execute()
            .map { [unowned self] posts in
                self.posts = posts
                return .reloadData
            }
            .bind(to: onActionSubject)
            .disposed(by: disposeBag)
    }
    
    func homeViewControllerDidSelectImage(_ image: UIImage) {
        onActionSubject.onNext(.showImage(image))
    }
}
