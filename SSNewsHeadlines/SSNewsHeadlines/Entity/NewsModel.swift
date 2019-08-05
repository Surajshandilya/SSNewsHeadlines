//
//  NewsModel.swift
//  SSNewsHeadlines
//
//  Created by Suraj Shandil on 7/25/19.
//  Copyright © 2019 Suraj Shandil. All rights reserved.
//

import Foundation

struct Articles: Decodable {
    var articles: [NewsDetails]?
}
struct NewsDetails: Codable {
    var author: String?
    var content: String?
    var description: String?
    var title: String?
    var publishedAt: String?
    var url: String?
    var urlToImage: String?
    
//    enum CodingKeys: String, CodingKey {
//        case userId
//        case id
//        case title
//        case completed
//    }
}
