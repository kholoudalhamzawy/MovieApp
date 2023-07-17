//
//  registerViewController.swift
//  movies
//
//  Created by KH on 18/01/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
class registerViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        register.titleLabel?.text = "register".localized()
        userName.placeholder = "user name".localized()
        password.placeholder = "password".localized()
    }
    
    
    @IBAction func rigesterPressed(_ sender: UIButton) {
        
        if let email = userName.text, let password = password.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: k.registerSegue, sender: self)
                }
            }
        }
            
       
    }
    
}
