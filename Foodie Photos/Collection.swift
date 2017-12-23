//
//  Collection.swift
//  Foodie Photos
//
//  Created by Rohan Sanap on 22/12/17.
//  Copyright © 2017 The Rohan Sanap Tech Studios. All rights reserved.
//

import Foundation

class Collection {
    var id: Int
    var res_count: Int?
    var imgUrl: String?
    var url: String?
    var title: String?
    var description: String?
    var share_url: String?
    
    init?(dict: [String: Any]) {
        guard let collection = dict["collection"] as? [String: Any] else {
            return nil
        }
        
        guard let collectionId = collection["collection_id"] as? Int else {
            return nil
        }
        
        self.id = collectionId
        self.res_count = collection["res_count"] as? Int
        self.imgUrl = collection["image_url"] as? String
        self.url = collection["url"] as? String
        
        if let htmlEncodedTitle = collection["title"] as? String {
            self.title = String(htmlEncodedString: htmlEncodedTitle)
        }
        
        if let htmlEncodedDescription = collection["description"] as? String {
            self.description = String(htmlEncodedString: htmlEncodedDescription)
        }
        
        self.share_url = collection["share_url"] as? String
    }
}

extension String {
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
    
}
