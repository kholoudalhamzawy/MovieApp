//
//  discoverViewController.swift
//  movies
//
//  Created by KH on 18/12/2022.
//

import UIKit

class discoverViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var detailsButton: UIButton!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
              title = "Discover".localized()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpViews()
        detailsButton.titleLabel?.text = "Details".localized()


    }
    
    private func setUpViews(){
        detailsButton.layer.cornerRadius = 5
        
    }


}
