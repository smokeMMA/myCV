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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LoginVC
        if showText.hasSuffix("Mikhail") {
        destination.userNameTextField.text = destination.userName
            destination.userNameTextField.textColor = .black
        }
        if showText.hasSuffix("12345") {
            destination.passwordTextField.text = destination.userPassword
            destination.passwordTextField.textColor = .black
        }
    }
}

