//
//  Article.swift
//  TASimpleApp
//
//  Created by Marutharaj Kuppusamy on 10/19/18.
//  Copyright © 2018 ta. All rights reserved.
//

import Foundation

struct MediaMetaData: Codable {
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?
    
    private enum CodingKeys: String, CodingKey {
        case url
        case format
        case height
        case width
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try? values.decode(String.self, forKey: .url)
        format = try? values.decode(String.self, forKey: .format)
        height = try? values.decode(Int.self, forKey: .height)
        width = try? values.decode(Int.self, forKey: .width)
    }
}

struct Media: Codable {
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let approvedForSyndication: Int?
    let mediaMetaData: [MediaMetaData]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetaData = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try? values.decode(String.self, forKey: .type)
        subtype = try? values.decode(String.self, forKey: .subtype)
        caption = try? values.decode(String.self, forKey: .caption)
        copyright = try? values.decode(String.self, forKey: .copyright)
        approvedForSyndication = try? values.decode(Int.self, forKey: .approvedForSyndication)
        
        if let decodedMediaMetaData = try? values.decode([MediaMetaData].self, forKey: .mediaMetaData) {
            mediaMetaData = decodedMediaMetaData
        } else {
            mediaMetaData = []
        }
    }
}

struct Article: Codable {
    let url: String?
    let adxKeywords: String?
    let column: String?
    let section: String?
    let byline: String?
    let type: String?
    let title: String?
    let abstract: String?
    let publishedDate: String?
    let source: String?
    let articleId: Int?
    let assetId: Int?
    let views: Int?
    let desFacet: [String]?
    let orgFacet: [String]?
    let perFacet: [String]?
    let geoFacet: [String]?
    let media: [Media]
    
    private enum CodingKeys: String, CodingKey {
        case url
        case adxKeywords = "adx_keywords"
        case column
        case section
        case byline
        case type
        case title
        case abstract
        case publishedDate = "published_date"
        case source
        case articleId = "id"
        case assetId = "asset_id"
        case views
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try? values.decode(String.self, forKey: .url)
        adxKeywords = try? values.decode(String.self, forKey: .adxKeywords)
        column = try? values.decode(String.self, forKey: .column)
        section = try? values.decode(String.self, forKey: .section)
        byline = try? values.decode(String.self, forKey: .byline)
        type = try? values.decode(String.self, forKey: .type)
        title = try? values.decode(String.self, forKey: .title)
        abstract = try? values.decode(String.self, forKey: .abstract)
        publishedDate = try? values.decode(String.self, forKey: .publishedDate)
        source = try? values.decode(String.self, forKey: .source)
        articleId = try? values.decode(Int.self, forKey: .articleId)
        assetId = try? values.decode(Int.self, forKey: .assetId)
        views = try? values.decode(Int.self, forKey: .views)
        
        if let decodedDesFacet = try? values.decode([String].self, forKey: .desFacet) {
            desFacet = decodedDesFacet
        } else {
            desFacet = []
        }
        
        if let decodedOrgFacet = try? values.decode([String].self, forKey: .orgFacet) {
            orgFacet = decodedOrgFacet
        } else {
            orgFacet = []
        }
        
        if let decodedPerFacet = try? values.decode([String].self, forKey: .perFacet) {
            perFacet = decodedPerFacet
        } else {
            perFacet = []
        }
        
        if let decodedGeoFacet = try? values.decode([String].self, forKey: .geoFacet) {
            geoFacet = decodedGeoFacet
        } else {
            geoFacet = []
        }
        
        if let decodedMedia = try? values.decode([Media].self, forKey: .media) {
            media = decodedMedia
        } else {
            media = []
        }
    }
}

struct Articles: Codable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let articles: [Article]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case articles = "results"
    }
    
//    init(from decoder: Decoder) throws {
//        let cContainer = try decoder.container(keyedBy: CodingKeys.self)
//        if let estatus = try cContainer.decodeIfPresent(String.self, forKey: .status) {
//            status = estatus
//        }
//        
//        if let ecopyright = try cContainer.decodeIfPresent(String.self, forKey: .copyright) {
//            copyright = ecopyright
//        }
//        
//        if let enumResults = try cContainer.decodeIfPresent(Int.self, forKey: .numResults) {
//            numResults = enumResults
//        }
//    }
}

/*class MediaMetaData {
    var url: String = ""
    var format: String = ""
    var height: Int
    var width: Int
    init?(dictionary:[String:Any]) {
        guard let url = dictionary["url"],
            let format = dictionary["format"],
            let height = dictionary["height"],
            let width = dictionary["width"]
            else {
                return nil
        }
        self.url = url as! String
        self.format = format as! String
        self.height = height as! Int
        self.width = width as! Int
    }
}

class Media {
    var type: String = ""
    var subtype: String = ""
    var caption: String = ""
    var copyright: String = ""
    var approvedForSyndication: Int
    var mediaMetaData = [MediaMetaData]()
    
    init?(dictionary:[String:Any]) {
        guard let type = dictionary["type"],
            let subtype = dictionary["subtype"],
            let caption = dictionary["caption"],
            let copyright = dictionary["copyright"],
            let approvedForSyndication = dictionary["approved_for_syndication"],
            let mediaMetaDataArray = dictionary["media-metadata"] as? NSArray
            else {
                return nil
            }
        self.type = type as! String
        self.subtype = subtype as! String
        if caption is NSNull {
            self.caption = ""
        }
        else {
            self.caption = caption as! String
        }
        if copyright is NSNull {
            self.copyright = ""
        }
        else {
            self.copyright = copyright as! String
        }
        self.approvedForSyndication = approvedForSyndication as! Int
        for metaData in mediaMetaDataArray {
            self.mediaMetaData.append(MediaMetaData(dictionary: metaData as! [String : Any])!)
        }
    }
}

class Article {
    var url: String = ""
    var adxKeywords: String = ""
    var column: String = ""
    var section: String = ""
    var byline: String = ""
    var type: String = ""
    var title: String = ""
    var abstract: String = ""
    var publishedDate: Date
    var source: String = ""
    var id: Int
    var assetId: Int
    var views: Int
    var desFacet = [String]()
    var orgFacet = [String]()
    var perFacet = [String]()
    var geoFacet = [String]()
    var media : Media
    
    init?(dictionary:[String:Any],media: Media) {
        guard let url = dictionary["url"],
            let adxKeywords = dictionary["adx_keywords"],
            let column = dictionary["column"],
            let section = dictionary["section"],
            let byline = dictionary["byline"],
            let type = dictionary["type"],
            let title = dictionary["title"],
            let abstract = dictionary["abstract"],
            let publishedDate = dictionary["published_date"],
            let source = dictionary["source"],
            let id = dictionary["id"],
            let assetId = dictionary["asset_id"],
            let views = dictionary["views"],
            let desFacet = dictionary["des_facet"],
            let orgFacet = dictionary["org_facet"],
            let perFacet = dictionary["per_facet"],
            let geoFacet = dictionary["geo_facet"]
            else {
                return nil
        }
        self.url = url as! String
        self.adxKeywords = adxKeywords as! String
        if column is NSNull {
            self.column = ""
        }
        else {
            self.column = column as! String
        }
        self.section = section as! String
        self.byline = byline as! String
        self.type = type as! String
        self.title = title as! String
        self.abstract = abstract as! String
        self.publishedDate = TAUtility().dateFromString(date: publishedDate as! String)
        self.source = source as! String
        self.id = id as! Int
        self.assetId = assetId as! Int
        self.views = views as! Int
        if desFacet is [String] {
            self.desFacet = desFacet as! [String]
        }
        else {
            self.desFacet = [""]
        }
        if orgFacet is [String] {
            self.orgFacet = orgFacet as! [String]
        }
        else {
            self.orgFacet = [""]
        }
        if perFacet is [String] {
            self.perFacet = perFacet as! [String]
        }
        else {
            self.perFacet = [""]
        }
        if geoFacet is [String] {
            self.geoFacet = geoFacet as! [String]
        }
        else {
            self.geoFacet = [""]
        }
        self.media = media
    }
}*/
