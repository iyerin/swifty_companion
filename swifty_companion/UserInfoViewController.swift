//
//  UserInfoViewController.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 13/05/2019.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var login: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: UserData.shared.myUser.photo) {
            if let data = try? Data.init(contentsOf: url) {
                self.photo.image = UIImage(data: data)
            }
        }
        
        name.text = UserData.shared.myUser.name
        level.text = UserData.shared.myUser.level
        login.text = UserData.shared.myUser.login
       // photo.layer.cornerRadius = 20
        
    }
}

//                        for topic in jsonArray {
//                            if let name = topic["author"] as? NSDictionary {
//                               // alltopics.append(Topics(authorLogin: name["login"] as! String, authorID: name["id"] as! Int, name: topic["name"] as! String, topicID: topic["id"] as! Int, createdAt: topic["created_at"] as! String, messagesUrl: topic["messages_url"] as! String))
//                            } else {
//                                print("bad data")
//                            }
//                        }
