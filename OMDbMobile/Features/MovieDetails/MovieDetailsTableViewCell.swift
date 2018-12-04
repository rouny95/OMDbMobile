//
//  MovieDetailsTableViewCell.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 04/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit
import Nuke

class MovieDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var movieReleaseLabel: UILabel!
    @IBOutlet weak var moviePosterHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

    /// Assign the cell Data using the movieObject
    ///
    /// - Parameter movieObject: Single MmovieObject
    func setCellData(movieObject: Movie) {
        
        self.movieTitleLabel.text = ""
        self.movieTypeLabel.text = ""
        self.movieReleaseLabel.text = ""
        self.moviePosterImageView.image = nil
        self.moviePosterImageView.image = UIImage(named: "default")
        
        self.movieTitleLabel.text = movieObject.title.uppercased()
        let type =  movieObject.type ?? "Movie"
        self.movieTypeLabel.text = " Genere type: \(type.uppercased()) "
        let year = movieObject.releaseYear ?? "Not Avaibale"
        self.movieReleaseLabel.text = "Release Year: \(year) "
        if  let image = moviePosterImageView, let _ = movieObject.posterUrl {
            let fileUrl = URL(string: movieObject.posterUrl!)
            if UIApplication.shared.canOpenURL(fileUrl!) {
                Nuke.loadImage(with: fileUrl!, into: image)
            } else {
                self.moviePosterImageView.image = UIImage(named: "default")
            }
        } else {
            self.moviePosterImageView.image = UIImage(named: "default")
        }
    }

}

