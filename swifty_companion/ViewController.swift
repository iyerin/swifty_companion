//
//  ViewController.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 09/05/2019.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import UIKit


/*
TODO
 - unexisting user
 - project marks/ lo & pprivalo
 */
class ViewController: UIViewController {
    
    var myUser = UserData.shared.myUser
    
    @IBOutlet weak var background: UIImageView!
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
            if let res = response as? HTTPURLResponse {
                if res.statusCode != 200 {
                    print("Wrong status code: ", res.statusCode)
                    return
                }
            }
            if let err = error {
                print("Error: ", err)
            }
            else if let d = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: d) as? [String: Any] {
                        //print("auth: ", json)
                        UserData.shared.token = (json["access_token"] as! String?)!
                        print (UserData.shared.token)
                        UserData.shared.myUser.arrProjects = []
                         //   User(name: "", photo: "", level: 0, login: "", wallet: "", test: [], projects: [], projectsS: [[:]], arrProjects: [])
                        let url = ("https://api.intra.42.fr/v2/users/" + UserData.shared.myUser.login).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                        let escapedUrl = URL(string: url!)
                        var request = URLRequest(url: escapedUrl! as URL)
                        request.httpMethod = "GET"
                        request.setValue("Bearer " + UserData.shared.token, forHTTPHeaderField: "Authorization")
                        
                        let task = URLSession.shared.dataTask(with: request as URLRequest) {
                            (data, response, error) in
                            if let res = response as? HTTPURLResponse {
                                if res.statusCode != 200 {
                                    print("Wrong status code: ", res.statusCode)
                                    return
                                    
                                }
                            }
                            if let err = error {
                                print("Error: ", err)
                            }
                            else if let d = data {
                                do {
                                    let json = try JSONSerialization.jsonObject(with: d) as! [String: Any]
                                    if let photo = json["image_url"] {
                                        UserData.shared.myUser.photo = photo as! String
                                    }
                                    if let name = json["displayname"] {
                                        UserData.shared.myUser.name = name as! String
                                    }
                                    if let wallet = json["wallet"] {
                                        UserData.shared.myUser.wallet = "\(wallet)"
                                    }
                                    let cursus = json["cursus_users"] as! [[String: Any]]
                                    
                                    if let level = cursus.first!["level"] {
                                        let levelDouble = level as! Double
                                        UserData.shared.myUser.level = levelDouble
                                        
                                    }

                                    let skills = cursus.first!["skills"] as! [NSDictionary]
                                    UserData.shared.myUser.test = skills
                                    
                                    let projects = json["projects_users"] as! [[String: Any]]
                                    
                                    for project in projects {
                                        let cursusID = project["cursus_ids"] as! [NSNumber]
                                        let myId = cursusID.first!
                                        
                                        let projectDetails = project["project"] as! [String:Any]
                                        
                                        let parentID: NSNumber
                                        if (projectDetails["parent_id"] is NSNull) {
                                            parentID = 0
                                        }
                                        else {
                                            parentID = projectDetails["parent_id"] as! NSNumber
                                        }
                                        
                                        let name = projectDetails["name"] as! String

                                        let finished: Bool
                                        if project["status"] as! String == "finished" {
                                            finished = true
                                        } else {
                                            finished = false
                                        }
                                        
                                        let mark: Int
                                        if (project["final_mark"] is NSNull) {
                                            mark = 0
                                        }
                                        else {
                                            mark = (project["final_mark"] as! NSNumber).intValue
                                        }
                                        
                                        let validated: Bool
                                        if (project["validated?"] is NSNull) {
                                            validated = false
                                        }
                                        else {
                                            validated = project["validated?"] as! Bool
                                        }
                                        
                                        if ((myId == 1) && (parentID == 0)) && (finished == true){
                                            let newProject = Project(name: name, mark: mark, finished: finished, validated: validated)
                                            UserData.shared.myUser.arrProjects.append(newProject)
                                            print (newProject)
                                        }
                                        
                                    }

                                    UserData.shared.myUser.projectsS = projects

                                    DispatchQueue.main.async {
                                        self.performSegue(withIdentifier: "ToUser", sender: self)
                                        self.activity.stopAnimating()
                                        self.activity.isHidden = true
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

