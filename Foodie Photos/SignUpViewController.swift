//
//  SignUpViewController.swift
//  Foodie Photos
//
//  Created by Rohan Sanap on 22/12/17.
//  Copyright © 2017 The Rohan Sanap Tech Studios. All rights reserved.
//

import UIKit
import RealmSwift

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    var realm: Realm!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goBackToLoginScreen(_ sender: UIButton) {
        LoginViewController.show()
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces),
                let password = passwordTextField.text,
                let retypedPassword = passwordTextField.text else {
                    
                showErrorAlert("Filling all fields is mandatory")
                return
        }
        
        guard !email.isEmpty && !password.isEmpty && !retypedPassword.isEmpty else {
            showErrorAlert("Filling all fields is mandatory")
            return
        }
        
        guard password == retypedPassword else {
            showErrorAlert("Text entered in password filed and password confirmation field do not match")
            return
        }
        
        if let _ = realm.objects(User.self).filter("email == %@", email).first {
            showErrorAlert("User with this email address already exist. Please use another email address.")
        }else {
            let user = User()
            user.email = email
            user.password = password
            
            try! realm.write({
                self.realm.add(user)
                UserDefaults.standard.set(user.email, forKey: "loggedIn")
                MainViewController.show()
            })
        }
        
    }
    
    class func show() {
        let signupVC = UIStoryboard.main.instantiateViewController(withIdentifier: "signupVC") as! SignUpViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = signupVC
    }
    
    func showErrorAlert(_ msg: String) {
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    

}
