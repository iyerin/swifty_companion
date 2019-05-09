//
//  ViewController.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 09/05/2019.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myToken: String = ""
    struct User {
        var login: String
    }
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
                        self.myToken = (json["access_token"] as! String?)!
                        print ("token = ", self.myToken)
                    }
                }
                catch (let err) {
                    print("Err: ", err)
                }
            }
        }
        task.resume()
    }
    
    func getUser() {
        let url = ("https://api.intra.42.fr/v2/users/iyerin").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let escapedUrl = URL(string: url!)
        var request = URLRequest(url: escapedUrl! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer 6c8a0dd5b8581788c43f33714ddff5dbdbe5d55e6e3caabf28b499c7d3d2f4b3", forHTTPHeaderField: "Authorization")

        
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
                    print (json)
//                    if let jsonArray = json as? [[String: Any]] {
//                        for topic in jsonArray {
//                            if let name = topic["author"] as? NSDictionary {
//                               // alltopics.append(Topics(authorLogin: name["login"] as! String, authorID: name["id"] as! Int, name: topic["name"] as! String, topicID: topic["id"] as! Int, createdAt: topic["created_at"] as! String, messagesUrl: topic["messages_url"] as! String))
//                            } else {
//                                print("bad data")
//                            }
//                        }
//                    }
                }
                catch (let err) {
                    print("Err: ", err)
                }
            }
        }
        task.resume()
    }
    
//    func getUser() {
//        //"Authorization: Bearer YOUR_ACCESS_TOKEN" "https://api.intra.42.fr/v2/users/2"
//        let urlString = "https://api.intra.42.fr/v2/users/2"
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            print (1)
//        }
//        //let url = ("https://api.intra.42.fr/oauth/token").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
////        let escapedUrl = URL(string: url!)
////        var request = URLRequest(url: escapedUrl! as URL)
////        request.httpMethod = "POST"
////        let postStr = "grant_type=client_credentials&client_id=308d70c3b9e32ff8b77b5df63c77962b610b30511bf87c7695802ea47b101a41&client_secret=17757718997ac2a3037ec3c9b3bf6fdef809fc27c9d35f300924c157fe63b9f5"
////        request.httpBody = postStr.data(using: String.Encoding.utf8)
////        let task = URLSession.shared.dataTask(with: request as URLRequest) {
////            (data, response, error) in
////            if let err = error {
////                print("Error: ", err)
////            }
////            else if let d = data {
////                do {
////                    if let json = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? [String: Any] {
////                        print("auth: ", json)
////                        //                        let token = (json["access_token"] as! String?)!
////                        //                        print ("token = ", token)
////                        self.myToken = (json["access_token"] as! String?)!
////                        print ("token = ", self.myToken)
////                    }
////                }
////                catch (let err) {
////                    print("Err: ", err)
////                }
////            }
//   //     }
//     //   task.resume()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getToken()
        getUser()
    }




}

