//
//  Article.swift
//  TASimpleApp
//
//  Created by Marutharaj Kuppusamy on 10/19/18.
//  Copyright © 2018 ta. All rights reserved.
//

import Foundation

class MediaMetaData {
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
}
