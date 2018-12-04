//
//  Movie.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 03/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import Foundation
import UIKit

/// Movie List Model to store all the details of the movies

struct Movie {
    
    var title: String = ""
    var releaseYear: String?
    var imdbId: String?
    var type: String?
    var posterUrl: String?
    
    init() {
    }
    
    /// Model Initalizer
    ///
    /// - Parameter dictionary: Response of the API as NSDictionary
    init?(dictionary : NSDictionary) {
        
        if let _ = dictionary.object(forKey: "Title") {
            self.title = dictionary["Title"] as! String
        } else {
            self.title = "Batman Coming Soon"
        }
        if let _ = dictionary.object(forKey: "Year")  {
            var year = dictionary.object(forKey: "Year") as! String
            if year.count > 4 {
                year = String(year.prefix(4))
            }
            if self.validateReleaseyear(year) {
               self.releaseYear = year
            } else {
               self.releaseYear = "2018"
            }
        }
        if let _ = dictionary.object(forKey: "imdbID") {
            self.imdbId = dictionary["imdbID"] as? String
        }
        if let _ = dictionary.object(forKey: "Type") {
            self.type = dictionary["Type"] as? String
        }
        if let _ = dictionary.object(forKey: "Poster") {
            self.posterUrl = dictionary["Poster"] as? String
        }
    }
    
    /// Validates If release year contains only Integers or not in the string
    ///
    /// - Parameter year: Year as String
    /// - Returns: returns true if contains only integers, else false
    func validateReleaseyear(_ year: String) -> Bool {
        let set = NSCharacterSet.letters
        if year != "" {
            if let _ = year.rangeOfCharacter(from: set, options: .caseInsensitive) {
                return false
            }
            return true
        }
        return false
    }
    
    /// validates wether a movie have a title is empty or not.
    ///
    /// - Parameter name: Movie name
    /// - Returns: Retrune TRUE is not empty, else false
    func validateMovieTitle(name: String) -> Bool {
        if name != "" {
            return true
        }
        return false
    }
    
    /// Check if the url given for movie poster is valid or not
    ///
    /// - Parameter posterUrl: Poster Url as String
    /// - Returns: returns TRUE if valid url, else false
    func isPosterUrlValid(posterUrl: String?) -> Bool {
        if posterUrl != nil {
            let fileUrl = URL(string: posterUrl!)
            if UIApplication.shared.canOpenURL(fileUrl!) {
                return true
            } else {
                 return false
            }

        }
        return false
    }
}
