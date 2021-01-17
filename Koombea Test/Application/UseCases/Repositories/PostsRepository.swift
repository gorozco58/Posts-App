//
//  PostsRepository.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 17/01/21.
//

import Foundation
import RxSwift

protocol PostsRepository {
    func savePosts(_ posts: [Post]) -> Observable<[Post]>
    func getPosts() -> Observable<[Post]>
}

class PostsRepositoryAdapter: PostsRepository {
    
    private var storage: DataBaseManager
    
    init(storage: DataBaseManager = .shared) {
        self.storage = storage
    }
    
    func savePosts(_ posts: [Post]) -> Observable<[Post]> {
        return Observable.create { [storage] observable in
            do {
                try storage.flushDB()
                try posts.forEach {
                    if let dict = $0.asDictionary {
                        try storage.saveDictionary(dict, forKey: $0.id)
                    }
                }
                observable.onNext(posts)
            } catch {
                observable.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func getPosts() -> Observable<[Post]> {
        return Observable.create { [storage] observable in
            do {
                let posts: [Post] = try storage
                    .getAllRecords()
                    .map { try JSONDecoder.model(with: $0) }
                observable.onNext(posts)
            } catch {
                observable.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
