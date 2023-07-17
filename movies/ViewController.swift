//
//  ViewController.swift
//  movies
//
//  Created by KH on 18/12/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        settings()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5136051178, green: 0.5133855939, blue: 0.5340548754, alpha: 1)
    }
    
    private func settings(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: nil)
        
    }

}

