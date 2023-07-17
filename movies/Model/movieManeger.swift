//
//  movieManeger.swift
//  movies
//
//  Created by KH on 01/01/2023.
//

import Foundation
import UIKit

protocol MovieManegerDelegate{
    func didUpdateMovie(_ movieManegerr: movieManeger, _ movies: [movie])
    func didFailWithError(error: Error)
}

struct movieManeger {
        
    var delegate: MovieManegerDelegate?
    
   
    
   
    func performRequest(pageNum: Int, movieURL: String){
      
        //1. create a URL
        if let url = URL(string: movieURL+String(pageNum)){
            //2. create a URLSession
            let session = URLSession(configuration: .default)
            //3. give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let movies = self.parseJSON(safeData){
                        sleep(3)
                        self.delegate?.didUpdateMovie(self, movies)
                    }
                    
                }
            }
            //4. start the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ movieData: Data) -> [movie]?{
        let decoder = JSONDecoder()
        var movies = [movie]()
        do{
            let decodedData =  try decoder.decode(moviesData.self, from: movieData)
            for i in 0..<decodedData.results.count {
                let name = decodedData.results[i].originalTitle
                let releaseDate = decodedData.results[i].releaseDate
                let disription = decodedData.results[i].overview
                let totalPages = decodedData.totalPages
                
                let  ImageBaseUrl = "https://image.tmdb.org/t/p/w500"
                var imagedata: UIImage?
                if let path = decodedData.results[i].posterPath{
                    let url = URL(string: ImageBaseUrl + path)
                    if let image = try? Data(contentsOf: url!){
                        imagedata = UIImage(data: image)
                    }
                }
               
                    
                let movie = movie(image: imagedata, name: name, releaseDate: releaseDate, Discription: disription, totalPages: totalPages)
                movies.append(movie)
            }
            return movies
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
