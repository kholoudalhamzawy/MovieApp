//
//  moviesModel.swift
//  movies
//
//  Created by KH on 31/12/2022.
//

import UIKit


struct MoviesBrain{
    
    var arrOfMovies = [movie]()
    var Movies = [movie]()
    var favMovies = [movie]()
    
    
     
    func getArrOfMovies() -> [movie]{
        return arrOfMovies
    }
    func getMovies() -> [movie]{
        return Movies
    }
    mutating func reloadMovies(){
        Movies = arrOfMovies
    }
    
}


struct movie{
    var image : UIImage?
    var name : String
    var releaseDate : String
    var Discription: String
    var totalPages: Int
}


enum movieURL: String {
    
    case nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=32c6fcb48eb9f8aba840a7e9dbe4188c&language=en-US&page="
    case upComing = "https://api.themoviedb.org/3/movie/upcoming?api_key=32c6fcb48eb9f8aba840a7e9dbe4188c&language=en-US&page="
    case popular = "https://api.themoviedb.org/3/movie/popular?api_key=32c6fcb48eb9f8aba840a7e9dbe4188c&language=en-US&page="

    
}
