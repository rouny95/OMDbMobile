//
//  MovieListViewController.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 03/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit

class MovieListViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var footerActivityIndicator: UIActivityIndicatorView!
    
    var movieList = [Movie]()
    var currentPageIndex: Int = 1
    var isLoadingMore: Bool = false
    var shouldLoadMore: Bool = false
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.getMovieList()
    }
    
    override func didReceiveMemoryWarning() {
    }

    //MARK: - Utility Methods
    
    
    /// Reloads the collectionview after the api call
    func updateUI() {
        DispatchQueue.main.async {
            super.stopAnimating()
            self.collectionView.reloadData()
            self.footerView.isHidden = true
            self.footerActivityIndicator.stopAnimating()
            self.isLoadingMore = false
        }
    }

    //MARK: - ScrollView Methods
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height  {
            self.footerView.isHidden = false
            self.footerActivityIndicator.startAnimating()
            // When scrollview reaches the bottom of the frame, api call is made for more data
            if ((shouldLoadMore) && !(isLoadingMore)){
                self.getMovieList()
            }
        }
    }
    
    //MARK: - Screen Orientation Methods
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        super.stopAnimating()
        self.collectionView.reloadData()
        self.footerView.isHidden = true
        self.footerActivityIndicator.stopAnimating()
        self.isLoadingMore = false
    }
    
    //MARK: - APIManager Methods
    
    /** Call APIManager Fnction to get the list of orders **/
    func getMovieList() {
        if self.currentPageIndex > 0 {
            if self.currentPageIndex == 1 {
                super.startAnimating()
            } else {
                self.isLoadingMore = true
            }
            ApiManager.sharedInstance.getMovieList(currentPageIndex, movieName: MovieNameConstants.BATMAN,  completion: {(response) -> Void in
                
                let responseMessage = DataParser.sharedInstance.returnParsedResponseMessage((response as? NSDictionary)!)
                
                if responseMessage.lowercased() == ResponseMessageConstants.FALSE {
                    
                    self.shouldLoadMore = false
                    self.currentPageIndex = 0
                    self.footerView.isHidden = true
                    self.footerActivityIndicator.stopAnimating()
                    self.isLoadingMore = false
                    
                } else if responseMessage.lowercased() == ResponseMessageConstants.TRUE {
                    
                    if let movies: [NSDictionary] = (response["Search"] as? [NSDictionary]) {
                        for movie in movies {
                            self.movieList.append(Movie(dictionary: movie)!)
                        }
                        self.currentPageIndex = self.currentPageIndex + 1
                        self.shouldLoadMore = true
                        self.updateUI()
                    } else {
                        self.shouldLoadMore = true
                        self.updateUI()
                    }
                } else {
                    super.stopAnimating()
                    super.showAlertMessage(message: ErrorMEssage.SOMETHING_WRONG)
                }
                
            }, errorHandler: {(error) -> Void in
                super.stopAnimating()
                super.showAlertMessage(message: ErrorMEssage.SOMETHING_WRONG)
            })
        }
    }

}

//MARK: - CollectionView Methods

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.bounds.width/2.0)
        let cellHeight = cellWidth + 80
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
        cell.setCellData(self.movieList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailsVC.movieObject = self.movieList[indexPath.item]
        self.present(movieDetailsVC, animated: true, completion: nil)
    }
    
}
