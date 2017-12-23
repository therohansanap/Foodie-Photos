//
//  APICaller.swift
//  Foodie Photos
//
//  Created by Rohan Sanap on 22/12/17.
//  Copyright © 2017 The Rohan Sanap Tech Studios. All rights reserved.
//

import Foundation
import Alamofire

class APICaller {
    
    static let headers: HTTPHeaders = [
        "Authorization" : "Bearer FlochatIosTestApi"
    ]
    
    class func getCollections(success: @escaping ([Collection]) -> Void , failure: @escaping (String) -> Void ) {
        Alamofire.request("http://35.154.75.20:9090/test/ios", method: .get, parameters: nil, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let result):
                if let result = result as? [String: Any] {
                    if let collections = result["collections"] as? [[String: Any]] {
                        var collectionObjects = [Collection]()
                        for collection in collections {
                            if let collectionObject = Collection(dict: collection) {
                                collectionObjects.append(collectionObject)
                            }
                        }
                        success(collectionObjects)
                        return
                    }
                }
                failure("Unexpected response from server.")
                return
            case .failure(let error):
                failure(APICaller.parseErrorAndGiveMessage(givenError: error as NSError))
                return
            }
        }
    }
    
    class func parseErrorAndGiveMessage(givenError: NSError) -> String {
        if givenError.domain == NSURLErrorDomain {
            switch givenError.code {
            case -1001: return "Request timed out."
            case -999:  return "Request cancelled."
            case -1011: return "Bad server response."
            case -1005: return "Network connection lost."
            case -1009: return "Not connected to Internet."
            default:    return "A network error occured."
            }
        }else {
            return "Server response error."
        }
    }
    
}
