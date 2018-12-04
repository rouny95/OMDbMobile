//
//  DataParser.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 04/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import Foundation

class DataParser: NSObject {
    class var sharedInstance : DataParser {
        struct Static {
            static let instance : DataParser = DataParser()
        }
        return Static.instance
    }
    
    func returnParsedResponseMessage(_ response : NSDictionary) -> String {
        
        if let _ = response.object(forKey: "Response") {
            let message =  response.object(forKey: "Response") as! String
            return message.lowercased()
        }
        return "false"
    }
    
    func returnParsedErrorMessage(_ response : NSDictionary) -> String {
        
        if let _ = response.object(forKey: "Error") {
            let message =  response.object(forKey: "Error") as! String
            return message
        }
        return "Movie not found!"
    }
}
