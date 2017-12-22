//
//  User.swift
//  Foodie Photos
//
//  Created by Rohan Sanap on 22/12/17.
//  Copyright © 2017 The Rohan Sanap Tech Studios. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email = ""
    @objc dynamic var password = ""
}
