//
//  UserData.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 13/05/2019.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import Foundation

class UserData {
    
    static let shared = UserData()

    struct User {
        var name: String
        var photo: String
        var level: String
        var login: String
    }
    
    var myUser = User(name: "", photo: "", level: "", login: "")
    var token: String = ""
}
