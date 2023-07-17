//
//  movieTableViewCell.swift
//  movies
//
//  Created by KH on 19/12/2022.
//

import UIKit

class movieTableViewCell: UITableViewCell {

    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var movieDescriptionLbl: UILabel!
    @IBOutlet weak var movieRealeseDateLbl: UILabel!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var tableCellImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(image: UIImage?, name: String, date: String, discription: String){
        tableCellImg.image = image
        movieNameLbl.text = name
        movieRealeseDateLbl.text = date
        movieDescriptionLbl.text = discription
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
}
