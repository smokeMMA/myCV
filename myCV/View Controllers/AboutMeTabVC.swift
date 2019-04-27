//
//  SecondVC.swift
//  myCV
//
//  Created by Михаил Медведев on 24/04/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class AboutMeTabVC: UIViewController {
    
    var userName = ""
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        userNameLabel.text = userName
    }
    
}
