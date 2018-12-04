//
//  MovieListCollectionViewCell.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 04/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit
import Nuke

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieReleaseTimeLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    
    override func awakeFromNib() {
    }
    
    /// Assign the cell Data using the movieObject
    ///
    /// - Parameter movieObject: Single MmovieObject
    func setCellData(_ movieObject: Movie) {
        
        // Empty all the objects when the cells are reused, to remove cached data.
        self.movieReleaseTimeLabel.text = ""
        self.movieTitleLabel.text = ""
        self.movieTypeLabel.text = ""
        self.moviePosterImageView.image = UIImage()
        self.moviePosterImageView.image = UIImage(named: "default")
        
        let title = movieObject.title
        self.movieTitleLabel.text = " \(title)  "
        self.movieTypeLabel.text = movieObject.type?.uppercased() ?? "MOVIE"
        
        //sets the movie poster image
        if let image = self.moviePosterImageView, let _ = movieObject.posterUrl {
            let fileUrl = URL(string: movieObject.posterUrl!)
            if UIApplication.shared.canOpenURL(fileUrl!) {
                Nuke.loadImage(with: fileUrl!, into: image)
            } else {
                self.moviePosterImageView.image = UIImage(named: "default")
            }
        } else {
            self.moviePosterImageView.image = UIImage(named: "default")
        }
        
        // Set the text for movieReleaseTimeLabel, how many years back the movie was released
        if let _ = movieObject.releaseYear {
            let  movieReleaseDateString = Util.sharedInstance.createDateFromYear(year: movieObject.releaseYear!)
            let movieReleaseTime = Util.sharedInstance.getMessageForGapInYearBetweenTwoDates(movieDate: movieReleaseDateString)
            self.movieReleaseTimeLabel.text = movieReleaseTime
        } else {
            self.movieReleaseTimeLabel.text = "Release Date Not Available"
        }
        
        
    }
}
