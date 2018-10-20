//
//  ArticleService.swift
//  TASimpleApp
//
//  Created by Marutharaj Kuppusamy on 10/19/18.
//  Copyright © 2018 ta. All rights reserved.
//

import Foundation

class ArticleService {
    var article = [Article]()
    
    init() {
        
    }
    
    func sendRequest(period: Int, completionHandler:@escaping (_ articles: [Article])->Void) {
        let methodName : String = "all-sections/" + String(period) + ".json"
        let queryString : String = "?api-key=" + ServiceConstants.API_KEY
        let url = URL(string: ServiceConstants.ARTICLE_URL + methodName + queryString)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: [JSONSerialization.ReadingOptions.mutableContainers])) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            guard let results = json["results"] as? NSArray else {
                return
            }
            
            
            print(results)
            var articles = [Article]()
            for result in results {
                let article: Article = TAUtility().convertJSONStringToArticle(json: result as! NSDictionary)
                articles.append(article)
            }
            
            completionHandler(articles)
        }
        
        task.resume()
    }
}
