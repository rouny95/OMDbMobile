//
//  ApiManager.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 03/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import Foundation
import Alamofire

public typealias ApiManagerResponse = (AnyObject) -> Void
public typealias ApiManagerError = (NSError?) -> Void

class ApiManager {
    let BASE_URL = "http://www.omdbapi.com/"
    
    class var sharedInstance : ApiManager {
        struct Static {
            static let instance : ApiManager = ApiManager()
        }
        return Static.instance
    }
    
    /// API call to get movie List
    ///
    /// - Parameters:
    ///   - pageNumber: Page Number for which we are requesting the movies
    ///   - movieName: Searched Movie Name
    ///   - completion: completion description
    ///   - errorHandler: errorHandler description
    func getMovieList(_ pageNumber: Int, movieName: String, completion : @escaping ApiManagerResponse, errorHandler : @escaping ApiManagerError) {
        
        Alamofire.request("\(BASE_URL)?s=\(movieName)&page=\(pageNumber)&apikey=\(KeyConstants.OMDAPIKEY)", method: .get , parameters: nil, encoding: URLEncoding.queryString , headers: [:])
            .responseJSON {
                (response) -> Void in
                switch response.result {
                case .success(let data):
                    if let _: AnyObject = data as AnyObject? {
                        completion(data as AnyObject)
                    }
                case .failure(let error):
                    let err : NSError = (error as NSError)
                    errorHandler(err);
                }
        }
    }
}

