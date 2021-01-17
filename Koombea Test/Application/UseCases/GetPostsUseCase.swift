//
//  GetPostsUseCase.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import Foundation
import RxSwift

protocol GetPostsUseCase {
    func execute() -> Observable<[Post]>
}

struct GetPostsUseCaseAdapter: GetPostsUseCase {
    
    var service: GetPostsService = GetPostsServiceAdapter()
    var repository: PostsRepository = PostsRepositoryAdapter()
    
    func execute() -> Observable<[Post]> {
        return service
            .getAll()
            .flatMap { [repository] in
                return repository.savePosts($0)
            }
            .catchError { [repository] _ in
                return repository.getPosts()
            }
    }
}
