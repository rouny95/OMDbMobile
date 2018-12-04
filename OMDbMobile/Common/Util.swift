//
//  Util.swift
//  OMDbMobile
//
//  Created by Raunak Choudhary on 04/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class Util: NSObject {
     class var sharedInstance : Util {
        struct Static {
            static let instance : Util = Util()
        }
        return Static.instance
    }
    
    /// To make the complete release date based upon the (01/01/year)
    ///
    /// - Parameter year: Movie Released year
    /// - Returns: Returns the date as string
    func createDateFromYear(year: String) -> String {
        let dateString = "\(year)-01-01"
        return dateString
    }
    
    ///
    ///
    /// - Parameter movieDate: Movie date in String
    /// - Returns: returns the message w.r.t no. of years ago movie was released
    func getMessageForGapInYearBetweenTwoDates(movieDate: String) -> String {
        
        let calendar: Calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "POSIX")
        
        let cuurentDateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: Date())
        
        let movieDateTime = dateFormatter.date(from: movieDate)!
        let  movieDateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: movieDateTime)
        
        let currentDate = calendar.date(from: cuurentDateComponents)
        let mDate = calendar.date(from: movieDateComponents)
        
        let flags = NSCalendar.Unit.year
        var components : DateComponents
        components = (calendar as NSCalendar).components(flags, from: currentDate!, to: mDate!, options: [])
        let numberOfYears =  abs(components.year!)
        
        if numberOfYears == 0 {
            return "Released this year only"
        } else if numberOfYears == 1 {
            return "Released \(numberOfYears) year ago"
        } else {
            return "Released \(numberOfYears) years ago"
        }
    }
    
}
