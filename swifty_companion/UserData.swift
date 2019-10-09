//
//  UserData.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 13/05/2019.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import Foundation

struct Project {
    let name: String
    let mark: Int
    let finished: Bool
    let validated: Bool
}

class UserData {
    
    static let shared = UserData()
    
    
    
    struct User {
        var name: String
        var photo: String
        var level: Double
        var login: String
        var wallet: String
        var test: [NSDictionary]
        var projects: [NSDictionary]
        var projectsS: [[String:Any]]
        var arrProjects: [Project]
    }
    
    var myUser = User(name: "", photo: "", level: 0, login: "", wallet: "", test: [], projects: [], projectsS: [[:]], arrProjects: [])
    var token: String = ""
}
