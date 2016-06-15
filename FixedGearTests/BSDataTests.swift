//
//  FixedGearTests.swift
//  FixedGearTests
//
//  Created by Brian Henry on 13/06/2016.
//  Copyright © 2016 Brian Henry. All rights reserved.
//

@testable import FixedGear

import XCTest
import MapKit

class FixedGearTests: XCTestCase {
    
    let coordinate1 = CLLocationCoordinate2D(latitude: 53.34338438, longitude: -6.249659657)
    let coordinate2 = CLLocationCoordinate2D(latitude: 53.34355492, longitude: -6.249551028)
    let coordinate3 = CLLocationCoordinate2D(latitude: 53.34363419, longitude: -6.261592805)
    let coordinate4 = CLLocationCoordinate2D(latitude: 53.34388319, longitude: -6.262097061)
    let coordinate5 = CLLocationCoordinate2D(latitude: 53.3447647, longitude: -6.268185675)
    let coordinate6 = CLLocationCoordinate2D(latitude: 53.34497847, longitude: -6.26422137)
    let coordinate7 = CLLocationCoordinate2D(latitude: 53.34502571, longitude: -6.266705096)

    var testCoordinates = [CLLocationCoordinate2D]()
    let data = BSData()
    
    override func setUp() {
        super.setUp()

        testCoordinates.append(coordinate1)
        testCoordinates.append(coordinate2)
        testCoordinates.append(coordinate3)
        testCoordinates.append(coordinate4)
        testCoordinates.append(coordinate5)
        testCoordinates.append(coordinate6)
        testCoordinates.append(coordinate7)
    }
    
    func testExample() throws {
                
        // Read in the file
        let bundle = NSBundle(forClass: self.classForCoder)
        //let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("cycle-final-07032016", ofType: "csv")!
        
        let content = try String(contentsOfFile: path)
     
        let bikeStands = data.parseCsv(content)
     
        XCTAssertEqual(384, bikeStands.count)
    }
    
    func testFindMaxLatPoint() {
        let maxLat = data.findMaxLatPoint(testCoordinates)
        XCTAssertEqualWithAccuracy(maxLat.longitude, coordinate7.longitude, accuracy: 8)
        XCTAssertEqualWithAccuracy(maxLat.latitude, coordinate7.latitude, accuracy: 8)
    }
    
    func testFindMinLatPoint() {
        let minLat = data.findMinLatPoint(testCoordinates)
        XCTAssertEqualWithAccuracy(minLat.longitude, coordinate1.longitude, accuracy: 8)
        XCTAssertEqualWithAccuracy(minLat.latitude, coordinate1.latitude, accuracy: 8)
    }
    
    func testFindMaxLongPoint() {
        let maxLong = data.findMaxLongPoint(testCoordinates)
        XCTAssertEqualWithAccuracy(maxLong.longitude, coordinate5.longitude, accuracy: 8)
        XCTAssertEqualWithAccuracy(maxLong.latitude, coordinate5.latitude, accuracy: 8)
    }
    
    func testFindMinLongPoint() {
        let minLong = data.findMinLongPoint(testCoordinates)
        XCTAssertEqualWithAccuracy(minLong.longitude, coordinate2.longitude, accuracy: 8)
        XCTAssertEqualWithAccuracy(minLong.latitude, coordinate2.latitude, accuracy: 8)
    }
  
    
    func testFindRegionShowingAll() {
        
//        -6.22726053
//        -6.300144196
//        53.33091783
//        53.36211259
        
    }
    
    func testIsUserWithinSquareArea() {
        // is his location between the lat min and max and also between the long min and max
        XCTAssert(data.isLocationWithinSquareArea(testCoordinates, location: coordinate4))
    }
    
    
}
