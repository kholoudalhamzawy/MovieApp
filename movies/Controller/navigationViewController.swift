//
//  originViewController.swift
//  movies
//
//  Created by KH on 18/12/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import MOLH

class navigationViewController: UIViewController {
    
  
    let currentLang = Locale.current.languageCode

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies".localized()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        settings()
        logout()
        lang()
        
    }
    
    private func settings(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: nil)
        
    }
    private func lang(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LanguageButton".localized(), style: .plain , target: self, action: #selector(changeLang))
        
    }
    
   @objc func changeLang(){
        let newlang = currentLang == "en" ? "ar" : "en"
        UserDefaults.standard.setValue([newlang], forKey: "AppleLanguages")
        exit(0)
    }
    
    private func logout(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "log out".localized(), style: .plain , target: self, action: #selector(signOut))
    }
    
    @objc func signOut(){
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }

}

    
extension String{
    func localized() -> String{
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
