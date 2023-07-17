//
//  welcomeViewController.swift
//  movies
//
//  Created by KH on 18/01/2023.
//

import UIKit
import MOLH

class welcomeViewController: UIViewController {

    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var register: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lang()
        logIn.titleLabel?.text = "log In".localized()
        register.titleLabel?.text = "register".localized()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    private func lang(){
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LanguageButton".localized(), style: .plain , target: self, action: nil)
        
    }
    

}
