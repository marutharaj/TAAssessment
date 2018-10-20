//
//  TAUtility.swift
//  TASimpleApp
//
//  Created by Marutharaj Kuppusamy on 10/20/18.
//  Copyright © 2018 ta. All rights reserved.
//

import Foundation

class TAUtility {
    func dateFromString(date: String)->Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        return dateFormatter.date(from: date)!
    }
    
    func stringFromDate(date: Date)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        return dateFormatter.string(from: date)
    }
    
    func convertJSONStringToArticle(json: NSDictionary)->Article {
        let mediaArray = json.object(forKey: "media") as? NSArray
        let media : Media = Media(dictionary: mediaArray![0] as! [String : Any])!
        return Article(dictionary: json as! [String : Any], media: media)!
    }
    
    func getArticleThumbnailUrl(article: Article)->URL {
        var imageUrlString : String = ""
        for mediaMetaData in article.media.mediaMetaData {
            if mediaMetaData.format == "Standard Thumbnail" {
                imageUrlString = mediaMetaData.url
                break
            }
        }
        
        return URL(string: imageUrlString)!
    }
}
