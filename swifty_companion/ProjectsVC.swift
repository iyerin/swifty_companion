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
        return (UserData.shared.myUser.arrProjects.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectsTable.dequeueReusableCell(withIdentifier: "ProjectsCell") as! ProjectsCell
        
        cell.projectName.text = UserData.shared.myUser.arrProjects[indexPath.row].name
        cell.projectMark.text = "\(UserData.shared.myUser.arrProjects[indexPath.row].mark)"
        if (UserData.shared.myUser.arrProjects[indexPath.row].validated) == true {
            cell.projectName.textColor = UIColor(red: 92/255, green: 184/255, blue: 92/255, alpha: 1)
            cell.projectMark.textColor = UIColor(red: 92/255, green: 184/255, blue: 92/255, alpha: 1)
        }
        else {
            cell.projectName.textColor = UIColor(red: 216/255, green: 99/255, blue: 111/255, alpha: 1)
            cell.projectMark.textColor = UIColor(red: 216/255, green: 99/255, blue: 111/255, alpha: 1)
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
