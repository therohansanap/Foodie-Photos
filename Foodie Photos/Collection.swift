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
        guard let collectionId = dict["collection_id"] as? Int else {
            return nil
        }
        
        self.id = collectionId
        self.res_count = dict["res_count"] as? Int
        self.imgUrl = dict["image_url"] as? String
        self.url = dict["url"] as? String
        self.title = dict["title"] as? String
        self.description = dict["description"] as? String
        self.share_url = dict["share_url"] as? String
    }
}
