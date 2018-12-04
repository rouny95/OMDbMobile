//
//  OMDbMobileTests.swift
//  OMDbMobileTests
//
//  Created by Raunak Choudhary on 04/12/18.
//  Copyright © 2018 Raunak. All rights reserved.
//

import XCTest
@testable import OMDbMobile

class OMDbMobileTests: XCTestCase {

    var movie: Movie!
    override func setUp() {
        super.setUp()
        
        movie = Movie()
        movie.releaseYear = "2016"
        movie.title = "Batman"
        movie.posterUrl = "https://m.media-amazon.com/images/M/MV5BNjE1YjQwNjEtMzlkNS00NThkLTgzNDItZWQ4YjRkMGZlNzJhXkEyXkFqcGdeQXVyODA1NjQ0OTY@._V1_SX300.jpg"
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        movie = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let yearTest = movie.validateReleaseyear(movie.releaseYear!)
        let titleTest = movie.validateMovieTitle(name: movie.title)
        let urlTest = movie.isPosterUrlValid(posterUrl: movie.posterUrl)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(yearTest, true, "Year is not in right format")
        XCTAssertEqual(titleTest, true, "A movie can not be without title")
        XCTAssertEqual(urlTest, true, "Poster Image url not valid")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
