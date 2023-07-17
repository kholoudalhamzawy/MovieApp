//
//  moviesViewController.swift
//  movies
//
//  Created by KH on 18/12/2022.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class moviesViewController: UIViewController {

    @IBOutlet weak var scrolView: UIScrollView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var segments: UISegmentedControl!
    
   
    var MovieBrain = MoviesBrain()
    var moviesManeger = movieManeger()
    var page = 1
    var movieUrl = movieURL.nowPlaying
    
    let db = Firestore.firestore()
    
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        let loadingIndecator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndecator.hidesWhenStopped = true
        loadingIndecator.style = UIActivityIndicatorView.Style.large
        loadingIndecator.startAnimating()
        alert.view.addSubview(loadingIndecator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    func stopLoader(loader: UIAlertController){
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }

    
    
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
        title = "Movies".localized()
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        pageLabel.text = NSLocalizedString("Now Playing", comment: "") //another way to use localization
        searchTxtField.placeholder = "Search Movie".localized()
        segments.setTitle("NowPlaying".localized(), forSegmentAt: 0)
        segments.setTitle("UpComing".localized(), forSegmentAt: 1)
        segments.setTitle("Trending".localized(), forSegmentAt: 2)
        tableView.delegate = self
        tableView.dataSource = self
        searchTxtField.delegate = self
        moviesManeger.delegate = self

        moviesManeger.performRequest(pageNum: page, movieURL: movieUrl.rawValue+String(page))


    }
    
}

// MARK: - MovieManegerDelegate

extension moviesViewController: MovieManegerDelegate{
    
    func didUpdateMovie(_ movieManegerr: movieManeger, _ movies: [movie]) {
        DispatchQueue.main.async {
            self.scrolView.isHidden = true
           // let loader = self.loader()
            self.loadingIndicator.startAnimating()
            self.page == 1 ? (self.MovieBrain.arrOfMovies = movies) : (self.MovieBrain.arrOfMovies.append(contentsOf: movies))
            self.MovieBrain.reloadMovies()
           // self.stopLoader(loader: loader)
            self.scrolView.isHidden = false
            self.tableView.reloadData()
            self.loadingIndicator.stopAnimating()

        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}


// MARK: - TableViewDelegate

extension moviesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MovieBrain.getMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! movieTableViewCell
        let data = MovieBrain.getMovies()[indexPath.row]
        cell.setUpCell(image: data.image, name: data.name, date: data.releaseDate, discription: data.Discription)
        cell.favorite.tag = indexPath.row  //every button has a tag of its own based on the number of the row
        cell.favorite.addTarget(self, action: #selector(addToFavorite(sender:)), for: .touchUpInside)
        
        return cell
    }
  
    @objc func addToFavorite(sender favorite: UIButton){
        if (favorite.image(for: .normal) == UIImage(systemName: "heart")){
            favorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favorite.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard page != MovieBrain.getMovies()[indexPath.row].totalPages else {return}
        if indexPath.row == MovieBrain.getMovies().count-2{
                print("load now playing ")
                page += 1
            moviesManeger.performRequest(pageNum: page, movieURL: movieUrl.rawValue+String(page))
                        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
    }
    
    
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
                               
        self.tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
   
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        switch segments.selectedSegmentIndex{
        case 0:
            movieUrl = movieURL.nowPlaying
        case 1:
            movieUrl = movieURL.upComing
        default:
            movieUrl = movieURL.popular
        }
        page = 1
        moviesManeger.performRequest(pageNum: page, movieURL: movieUrl.rawValue)
        tableView.reloadData()
        scrollToTop()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)    }
}


// MARK: - UISearchTextFieldDelegate


extension moviesViewController: UISearchTextFieldDelegate{
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func SearchBtn(_ sender: UIButton) {
        searchTxtField.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTxtField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty {
            textField.placeholder = "Type Something".localized()
            return false
        } else {
            textField.placeholder = "Search Movie".localized()
            return true

        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let movieName = searchTxtField.text, let user = Auth.auth().currentUser?.email {
            db.collection("Favorites").addDocument(data: ["favoriteMovie": movieName,"user": user]) { (error) in
                if let e = error {
                    print ("There was an issue saving the data to firestore, \(e)")
                } else {
                    print("successfully saved data")
                }
            }
        }
        searchTxtField.text = ""
        tableView.reloadData()
    }
    
    @IBAction func searchHandler(_ sender: UITextField) {
        if let searchText = sender.text{
            MovieBrain.Movies = searchText.isEmpty ? MovieBrain.arrOfMovies : MovieBrain.arrOfMovies.filter{$0.name.lowercased().contains(searchText.lowercased())}
            tableView.reloadData()
        }
    }
}

