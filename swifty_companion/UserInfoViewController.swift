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
    
    var myUser = UserData.shared.myUser
    
    func getToken() {
        let url = ("https://api.intra.42.fr/oauth/token").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let escapedUrl = URL(string: url!)
        var request = URLRequest(url: escapedUrl! as URL)
        request.httpMethod = "POST"
        let postStr = "grant_type=client_credentials&client_id=308d70c3b9e32ff8b77b5df63c77962b610b30511bf87c7695802ea47b101a41&client_secret=17757718997ac2a3037ec3c9b3bf6fdef809fc27c9d35f300924c157fe63b9f5"
        request.httpBody = postStr.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print("Error: ", err)
            }
            else if let d = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: d) as? [String: Any] {
                        print("auth: ", json)
                        UserData.shared.token = (json["access_token"] as! String?)!
                        let url = ("https://api.intra.42.fr/v2/users/" + UserData.shared.myUser.login).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        let escapedUrl = URL(string: url!)
                        var request = URLRequest(url: escapedUrl! as URL)
                        request.httpMethod = "GET"
                        request.setValue("Bearer " + UserData.shared.token, forHTTPHeaderField: "Authorization")
                        
                        
                        let task = URLSession.shared.dataTask(with: request as URLRequest) {
                            (data, response, error) in
                            if let res = response as? HTTPURLResponse {
                            }
                            if let err = error {
                                print("Error: ", err)
                            }
                            else if let d = data {
                                do {
                                    let json = try JSONSerialization.jsonObject(with: d)
                                    print("tyt")
                                    //  print (json)
                                    
                                    let jsonArray = json as? [String: Any]
                                    if let name = jsonArray!["image_url"]
                                    {
                                        UserData.shared.myUser.photo = name as! String
                                        print("name = ", name)
                                        
                                    }
                                    //                        for topic in jsonArray {
                                    //                            if let name = topic["author"] as? NSDictionary {
                                    //                               // alltopics.append(Topics(authorLogin: name["login"] as! String, authorID: name["id"] as! Int, name: topic["name"] as! String, topicID: topic["id"] as! Int, createdAt: topic["created_at"] as! String, messagesUrl: topic["messages_url"] as! String))
                                    //                            } else {
                                    //                                print("bad data")
                                    //                            }
                                    //                        }
                                }
                                catch (let err) {
                                    print("Err: ", err)
                                }
                            }
                        }
                        task.resume()
                    }
                }
                catch (let err) {
                    print("Err: ", err)
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1111")
        getToken()
        print(UserData.shared.myUser.photo)
        if let url = URL(string: UserData.shared.myUser.photo) {
            print("sddsfsdf")
            if let data = try? Data.init(contentsOf: url) {
                print("qwrwer")
                photo.image = UIImage(data: data)
            }
        }
        photo.layer.cornerRadius = 20
        
    }



}
