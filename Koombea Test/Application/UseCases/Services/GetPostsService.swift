//
//  GetPostsService.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import Foundation
import Alamofire
import RxSwift

protocol GetPostsService {
    func getAll() -> Observable<[Post]>
}

struct GetPostsServiceAdapter: GetPostsService {
    
    func getAll() -> Observable<[Post]> {
        return Observable.create { observable in
            AF.request(Request.posts)
                .log()
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let posts: PostsResponse = try JSONDecoder.model(with: data)
                            observable.onNext(posts.data)
                        } catch {
                            observable.onError(error)
                        }
                    case .failure(let error):
                        observable.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
