//
//  ViewController.swift
//  myCV
//
//  Created by Михаил Медведев on 24/04/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var isKeyboardAppear = false
    //MARK: Hardcode
    let userName = "Mikhail"
    let userPassword = "12345"
    
    //MARK: OUTLETS
    @IBOutlet weak var loginButtonTopConstarint: NSLayoutConstraint!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
}

extension LoginVC {
    
    enum ForgotCases: String {
        case userName = "Your user name: "
        case password = "Your password: "
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        checkTextFieldsWithSegue(sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        hideKeyboardFromTap()
        addObserverForKeyBoard()
    }
    
    //FOR TESTING TABS - DELETE BEFORE SENDING HW
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
        
        //Autologin
        //        userNameTextField.text = userName
        //        passwordTextField.text = userPassword
    }
    
    //set red colors to textfields if wrong input
    private func checkTextFieldsWithSegue(sender: Any?) {
        
        if userNameTextField.text == userName  && passwordTextField.text == userPassword {
            
            performSegue(withIdentifier: "toTabs", sender: sender)
            
        } else {
            
            if userNameTextField.text != userName {
                userNameTextField.textColor = .red
            }
            
            passwordTextField.textColor = .red
        }
    }
    
    //MARK: NAVIGATION
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        print(#line, #function, segue.identifier ?? "no identifier" )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //transfer information to ForgotVC
        if let destinationToForgot = segue.destination as? ForgotVC {
            
            //check button which tapped (tag 0 is user name / tag 1 is password)
            guard let tappedButton = sender as? UIButton else { return }
            
            if isKeyboardAppear {
                userNameTextField.resignFirstResponder()
                passwordTextField.resignFirstResponder()
            }
            
            switch tappedButton.tag {
            case 0:
                destinationToForgot.showText = ForgotCases.userName.rawValue + userName
            case 1:
                destinationToForgot.showText = ForgotCases.password.rawValue + userPassword
            default: break
            }
        }
        
        //transfer information to TabBarController
        
        if let destinationToTabs = segue.destination as? UITabBarController {
            guard let aboutMeVC = destinationToTabs.viewControllers![0] as? AboutMeTabVC else { return }
            aboutMeVC.userName = userName
        }
        
    }
    
}

//MARK: KEYBOARD SETUP AND DELEGATE

extension LoginVC: UITextFieldDelegate  {
    
    private func configureTextFields() {
        userNameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.textColor = .black
        textField.text = ""
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkTextFieldsWithSegue(sender: textField)
        textField.resignFirstResponder()
        return true
    }
    
    private func hideKeyboardFromTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    //MARK: SLIDE UP VIEW when Keyboard Appears
    
    private func addObserverForKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height / 2
                }
            }
            isKeyboardAppear = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height / 2
                }
            }
            isKeyboardAppear = false
        }
    }
    
}
