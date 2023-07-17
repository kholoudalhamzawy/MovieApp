//
//  loginViewController.swift
//  movies
//
//  Created by KH on 18/01/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class loginViewController: UIViewController {
    
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        logIn.titleLabel?.text = "log In".localized()
        userName.placeholder = "user name".localized()
        password.placeholder = "password".localized()
        
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let email = userName.text, let password = password.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: k.loginSegue, sender: self)
                }
                
            }
            
        }
        
    }
    
}
