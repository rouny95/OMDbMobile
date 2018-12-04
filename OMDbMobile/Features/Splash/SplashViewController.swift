//
//  SplashViewController.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 04/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presentMovieListVC()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    //MARK: - Navigation Methods
    
    /// Presents Movie List View Controller
    func presentMovieListVC() {
        let movieListVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        self.present(movieListVC, animated: true, completion: nil)
    }

}
