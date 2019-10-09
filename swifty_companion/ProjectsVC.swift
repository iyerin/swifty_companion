//
//  ProjectsVC.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 10/8/19.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import UIKit

class ProjectsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var projectsTable: UITableView!
    

    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print ("==========", UserData.shared.myUser.projects.count)
        return (UserData.shared.myUser.arrProjects.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = skillsTable.dequeueReusableCell(withIdentifier: "myCell") as! SkillsTableViewCell
//        //cell.textLabel?.text = (UserData.shared.myUser.test[indexPath.row]["name"] as! String)
//        cell.skillName.text = UserData.shared.myUser.test[indexPath.row]["name"] as? String
//        cell.skillLevel.text = "\(UserData.shared.myUser.test[indexPath.row]["level"]!)"
//        cell.skillProgress.progress = Float(UserData.shared.myUser.test[indexPath.row]["level"] as! Float)/21 //21???????????????
//        return cell
        
        
        let cell = projectsTable.dequeueReusableCell(withIdentifier: "ProjectsCell") as! ProjectsCell

        cell.projectName.text = UserData.shared.myUser.arrProjects[indexPath.row].name
        if (UserData.shared.myUser.arrProjects[indexPath.row].finished) == true {
            cell.projectMark.text = "\(UserData.shared.myUser.arrProjects[indexPath.row].mark)"
            if (UserData.shared.myUser.arrProjects[indexPath.row].validated) == true {
                cell.projectName.textColor = UIColor(red: 92/255, green: 184/255, blue: 92/255, alpha: 1)
            }
            else {
                cell.projectName.textColor = UIColor(red: 216/255, green: 99/255, blue: 111/255, alpha: 1)
            }
        }
        else {
            cell.projectName.textColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }



}
