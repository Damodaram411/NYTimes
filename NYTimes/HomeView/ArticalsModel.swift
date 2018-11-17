//
//  ArticalsModel.swift
//  NYTimes
//
//  Created by Damu on 15/11/18.
//  Copyright © 2018 Damu. All rights reserved.
//

import Foundation
struct PopularArticals: Codable {
    let status, copyright: String
    let numResults: Double
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

struct Result: Codable {
    let url: String
    let adxKeywords: String
    let column: String?
    let byline: String
    let type: ResultType
    let title, abstract, publishedDate: String
    let source: Source
    let id, assetID, views: Double
    let desFacet: [String]
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case url
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case publishedDate = "published_date"
        case source, id
        case assetID = "asset_id"
        case views
        case desFacet = "des_facet"
        case media
    }
}



struct Media: Codable {
    let type: MediaType
    let subtype: Subtype
    let caption, copyright: String?
    let approvedForSyndication: Double
    let mediaMetadata: [MediaMetadatum]
    
    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadatum: Codable {
    let url: String
    let format: Format
    let height, width: Double
}

enum Format: String, Codable {
    case jumbo = "Jumbo"
    case large = "Large"
    case largeThumbnail = "Large Thumbnail"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case normal = "Normal"
    case square320 = "square320"
    case square640 = "square640"
    case standardThumbnail = "Standard Thumbnail"
    case superJumbo = "superJumbo"
}

enum Subtype: String, Codable {
    case photo = "photo"
}

enum MediaType: String, Codable {
    case image = "image"
}



enum Source: String, Codable {
    case theNewYorkTimes = "The New York Times"
}

enum ResultType: String, Codable {
    case article = "Article"
    case interactive = "Interactive"
}
