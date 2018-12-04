//
//  MovieDetailsViewController.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 04/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import UIKit
import Nuke

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var movieObject = Movie()
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //MARK: - Screen Orientation Methods
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.tableView.reloadData()
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let requiredHeight =  UIScreen.main.bounds.width
        return requiredHeight + 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as! MovieDetailsTableViewCell
        let requiredHeight =  (UIScreen.main.bounds.width - 40 ) + 60
        cell.moviePosterHeightConstraint.constant = requiredHeight
        cell.layoutIfNeeded()
        self.view.layoutIfNeeded()
        cell.setCellData(movieObject: self.movieObject)
        return cell
    }
}

