//
//  SplashViewController.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 04/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.showsCancelButton = false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //MARK: - SearchBar Delegate Methods
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if self.searchBar.text != nil && self.searchBar.text! != "" {
            let seachedText = self.searchBar.text!
            self.searchBar.text = ""
            self.view.endEditing(true)
            if seachedText.count < 3 {
               super.showAlertMessage(message: "Movie Name should be greater than 3 characters")
            } else if seachedText.count > 20 {
                super.showAlertMessage(message: "Search a shorter movie name")
            } else {
               self.presentMovieListVC(searchedText: seachedText)
            }
        } else {
            super.showAlertMessage(message: "Please Search a movie")
        }
        
    }
    
    //MARK: - Navigation Methods
    
    /// Presents Movie List View Controller
    func presentMovieListVC(searchedText: String) {
        let movieListVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        movieListVC.searchedMovieName = searchedText
        self.present(movieListVC, animated: true, completion: nil)
    }

}
