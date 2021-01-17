//
//  Post.swift
//  Koombea Test
//
//  Created by Giovanny Orozco Loaiza on 16/01/21.
//

import Foundation

class PostsResponse: Codable {
    let data: [Post]
}

class Post: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "uid"
        case author = "name"
        case authorEmail = "email"
        case authorPicture = "profile_pic"
        case detail = "post"
    }
    
    enum Style {
        case normal
        case large
        case extended
    }
    
    let id: String
    let author: String
    let authorEmail: String
    let authorPicture: URL
    let detail: PostDetail
    
    var style: Style {
        switch detail.pics.count {
        case ...2:
            return .normal
        case 3:
            return .large
        default:
            return .extended
        }
    }
}

struct PostDetail: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case dateString = "date"
        case pics
    }
    
    let id: Int
    private let dateString: String
    let pics: [URL]
    
    var date: Date? {
        return dateString.toDate(format: Format.serverFormat.rawValue)
    }
    
    var dateFormatted: String {
        guard let date = date else { return "" }
        return date.toString(format: date.dateFormatWithSuffix())
    }
}
