//
//  UserInfoViewController.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 13/05/2019.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var skillsTable: UITableView!
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var projectsButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(UserData.shared.myUser.test.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = skillsTable.dequeueReusableCell(withIdentifier: "myCell") as! SkillsTableViewCell
        cell.skillName.text = UserData.shared.myUser.test[indexPath.row]["name"] as? String
        cell.skillLevel.text = "\(UserData.shared.myUser.test[indexPath.row]["level"]!)"
        if let level = UserData.shared.myUser.test[indexPath.row]["level"], let floatLvl = level as? Float {
            cell.skillProgress.progress = floatLvl / 21
        }
//        cell.skillProgress.progress = Float(UserData.shared.myUser.test[indexPath.row]["level"] as! Float)/21
        cell.skillProgress.trackTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        cell.skillProgress.tintColor = UIColor(red: 0/255, green: 186/255, blue: 188/255, alpha: 1)
        cell.skillProgress.layer.cornerRadius = 3
        cell.skillProgress.clipsToBounds = true
        return cell
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: UserData.shared.myUser.photo) {
            if let data = try? Data.init(contentsOf: url) {
                guard let rectImage = UIImage(data: data) else {return}
                let squareImage = cropToBounds(image: rectImage, width: 100, height: 100)
                self.photo.image = squareImage
                self.photo.layer.borderWidth = 1    //layer.borderWidth = 1
                self.photo.layer.masksToBounds = false
                self.photo.layer.borderColor = UIColor.black.cgColor
                self.photo.layer.cornerRadius = self.photo.frame.height/2
                self.photo.clipsToBounds = true
            }
        }
        
        self.skillsTable.sectionHeaderHeight = 50
        name.text = UserData.shared.myUser.name
        level.text = "\(UserData.shared.myUser.level)"
        login.text = UserData.shared.myUser.login
        wallet.text = UserData.shared.myUser.wallet
        levelProgress.progress = Float(UserData.shared.myUser.level.truncatingRemainder(dividingBy: 1))
        levelProgress.trackTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        levelProgress.tintColor = UIColor(red: 0/255, green: 186/255, blue: 188/255, alpha: 1)
        levelProgress.layer.cornerRadius = 5
        levelProgress.clipsToBounds = true
        projectsButton.layer.cornerRadius = 10
        projectsButton.clipsToBounds = true
    }
}
