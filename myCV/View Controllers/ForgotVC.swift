//
//  ForgotVC.swift
//  myCV
//
//  Created by Михаил Медведев on 24/04/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class ForgotVC: UIViewController {
    
    var showText = ""
    
    @IBOutlet weak var showForgotThingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        showForgotThingLabel.text = showText
    }
}

