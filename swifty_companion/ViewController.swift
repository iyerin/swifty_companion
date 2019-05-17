//
//  ViewController.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 09/05/2019.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myUser = UserData.shared.myUser
    
    @IBAction func serchButton(_ sender: UIButton) {
        if let login = loginLabel.text {
            UserData.shared.myUser.login = login
            getToken()
            activity.isHidden = false
            activity.startAnimating()
        } else { return }
    }
    @IBOutlet weak var loginLabel: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
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
                        //print("auth: ", json)
                        UserData.shared.token = (json["access_token"] as! String?)!
                        let url = ("https://api.intra.42.fr/v2/users/" + UserData.shared.myUser.login).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        let escapedUrl = URL(string: url!)
                        var request = URLRequest(url: escapedUrl! as URL)
                        request.httpMethod = "GET"
                        request.setValue("Bearer " + UserData.shared.token, forHTTPHeaderField: "Authorization")
                        
                        let task = URLSession.shared.dataTask(with: request as URLRequest) {
                            (data, response, error) in
                            if (response as? HTTPURLResponse) != nil {
                                //print(res)
                            }
                            if let err = error {
                                print("Error: ", err)
                            }
                            else if let d = data {
                                do {
                                    let json = try JSONSerialization.jsonObject(with: d) as! [String: Any]
                                   // print(json)
                                    print("tyt")
                                    
                                    if let photo = json["image_url"] {
                                        UserData.shared.myUser.photo = photo as! String
                                    }
                                    if let name = json["displayname"] {
                                        UserData.shared.myUser.name = name as! String
                                    }
                                    let cursus = json["cursus_users"] as! [[String: Any]]
                                    print("cursus = ", cursus)
                                    
                                    if let level = cursus.first!["level"] {
                                        UserData.shared.myUser.level = String(format: "%@", level as! CVarArg)
                                        print("level = ", level)
                                    }
                                    //print(level)
//                                        if let level = cursus["level"] {
//                                            UserData.shared.myUser.name = level as! String
//                                        }
                                    

                                    print(UserData.shared.myUser)
                                    DispatchQueue.main.async {
                                        self.performSegue(withIdentifier: "ToUser", sender: self)
                                    }
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
        activity.isHidden = true

    }
}

