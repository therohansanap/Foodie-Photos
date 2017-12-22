//
//  ViewController.swift
//  Foodie Photos
//
//  Created by Rohan Sanap on 21/12/17.
//  Copyright © 2017 The Rohan Sanap Tech Studios. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSigupButton()
        
        realm = try! Realm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupSigupButton() {
        let attrs = [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12.0),
                      NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
        
        let attributedString = NSMutableAttributedString(string: signupButton.titleLabel!.text!, attributes: attrs)
        signupButton.setAttributedTitle(attributedString, for: .normal)
    }

    @IBAction func signupButtonTapped(_ sender: UIButton) {
        SignUpViewController.show()
    }
    
    class func show() {
        let loginVC = UIStoryboard.main.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces),
            let password = passwordTextField.text else {
            showErrorAlert("Filling all fields is important")
            return
        }
        
        guard !email.isEmpty && !password.isEmpty else {
            showErrorAlert("Filling all fields is important")
            return
        }
        
        if let user = realm.objects(User.self).filter("email = %@", email).first {
            if password == user.password {
                UserDefaults.standard.set(user.email, forKey: "loggedIn")
                MainViewController.show()
            }else {
                showWrongPasswordAlert()
            }
        }else {
            showSignUpAlert()
        }
    }
    
    func showSignUpAlert() {
        let alertController = UIAlertController(title: "Sign up", message: "You are not signed up yet. Please sign up.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let signUpAction = UIAlertAction(title: "Sign up", style: .default) { (action) in
            SignUpViewController.show()
        }
        alertController.addAction(signUpAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showWrongPasswordAlert() {
        let alertController = UIAlertController(title: "Wrong password", message: "Please enter correct password.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert(_ msg: String) {
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

