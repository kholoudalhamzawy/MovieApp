//
//  moviesData.swift
//  movies
//
//  Created by KH on 01/01/2023.
//

import Foundation

//    //the data encoded from json has to be of the same names as the json parameters
//struct moviesData: Codable{//decodable is being able to be endoded from json, encodable to json, and codable is typealies for both
//    let results: [result]
//
//}
//
//struct result: Codable{
//    let original_title: String
//    let overview: String
//    let release_date: String
//  //  let poster_path: String
//}
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)


import Foundation

// MARK: - Welcome
struct moviesData: Codable {
    
    let dates: Dates?
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case id = "id"
//    case ar = "ar"
//    case es = "es"
//    case ko = "ko"
//}
