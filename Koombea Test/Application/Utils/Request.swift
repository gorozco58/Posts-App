//
//  Request.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import Foundation
import Alamofire

enum Request: URLConvertible {
    
    case posts
    
    var baseURL: URL {
        return URL(string: "https://mock.koombea.io/mt/api")!
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        }
    }
    
    func asURL() -> URL {
        let endpoint = baseURL.appendingPathComponent(path)
        return endpoint
    }
}

public extension DataRequest {
    
    func log(_ fileName: String = #file, _ functionName: String = #function, _ lineNumber: Int = #line) -> DataRequest {
        responseJSON {
            switch $0.result {
            case .success(let response):
                Log.shared.info(response, fileName, functionName, lineNumber)
            case .failure:
                Log.shared.error($0.response, fileName, functionName, lineNumber)
            }
        }
        return self
    }
}
