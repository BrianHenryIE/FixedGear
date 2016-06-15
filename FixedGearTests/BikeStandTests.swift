//
//  BikeStandTests.swift
//  FixedGear
//
//  Created by Brian Henry on 14/06/2016.
//  Copyright © 2016 Brian Henry. All rights reserved.
//

@testable import FixedGear

import XCTest
import MapKit

class BikeStandTests: XCTestCase {

    func testTypeStands() {
        
        let sheffieldStand = TypeStands(rawValue: "Sheffield Stand")
        
        XCTAssertEqual(sheffieldStand, TypeStands.SheffieldStand)
        
        let railing = TypeStands(rawValue: "Railing")
        
        XCTAssertEqual(railing, TypeStands.Railing)
        
        let stainlessSteelCurved = TypeStands(rawValue: "Stainless Steel Curved")
        
        XCTAssertEqual(stainlessSteelCurved, TypeStands.StainlessSteelCurved)
        
        let hoops = TypeStands(rawValue: "Hoops")
        
        XCTAssertEqual(hoops, TypeStands.Hoops)
        
//        let nilTest = TypeStands(rawValue: nil)
//        
//        XCTAssertEqual(nilTest, nil)
    }
    
    func testPhysicalCondition() {
        
        let high = PhysicalCondition(rawValue: "High")
        
        XCTAssertEqual(high, PhysicalCondition.High)
        
        let medium = PhysicalCondition(rawValue: "Medium")
        
        XCTAssertEqual(medium, PhysicalCondition.Medium)
    }
    
    func testSecuritySafetyrating() {
        
        let high = SecuritySafetyrating(rawValue: "High")
        
        XCTAssertEqual(high, SecuritySafetyrating.High)
        
        let medium = SecuritySafetyrating(rawValue: "Medium")
        
        XCTAssertEqual(medium, SecuritySafetyrating.Medium)
    }
    
    func testLighting() {
      
        let high = Lighting(rawValue: "High")
        
        XCTAssertEqual(high, Lighting.High)
        
        let medium = Lighting(rawValue: "Medium")
        
        XCTAssertEqual(medium, Lighting.Medium)

        let low = Lighting(rawValue: "Low")
        
        XCTAssertEqual(low, Lighting.Low)
    }
    
    func testProtectionWeather() {
        
        let high = ProtectionWeather(rawValue: "High")
        
        XCTAssertEqual(high, ProtectionWeather.High)
        
        let medium = ProtectionWeather(rawValue: "Medium")
        
        XCTAssertEqual(medium, ProtectionWeather.Medium)
        
        let low = ProtectionWeather(rawValue: "Low")
        
        XCTAssertEqual(low, ProtectionWeather.Low)
    }
    
    func testLargeDevelopment() {
    
        let all = LargeDevelopment(rawValue: "All")
        
        XCTAssertEqual(all, LargeDevelopment.All)
    }
        
    func testEaseAccess() {
        
        let fair = EaseAccess(rawValue: "Fair")
        
        XCTAssertEqual(fair, EaseAccess.Fair)
        
        let good = EaseAccess(rawValue: "Good")
        
        XCTAssertEqual(good, EaseAccess.Good)
        
        let poor = EaseAccess(rawValue: "Poor")
        
        XCTAssertEqual(poor, EaseAccess.Poor)
    }
        
    func testProximityCyclenetwork() {
        
        let adjacentVisible = ProximityCyclenetwork(rawValue: "AdjacentVisible")
        
        XCTAssertEqual(adjacentVisible, ProximityCyclenetwork.AdjacentVisible)
        
        let unknown = ProximityCyclenetwork(rawValue: "Unknown")
        
        XCTAssertEqual(unknown, ProximityCyclenetwork.Unknown)
        
        let visible = ProximityCyclenetwork(rawValue: "Visible")
        
        XCTAssertEqual(visible, ProximityCyclenetwork.Visible)
    }

    func testMinimalBikeStand() {
        
        let minimalStandDict = ["type_stands": "Sheffield Stand",
                            "X":"-6.257431358",
                            "Y":"53.34837783",
                            "Easting":"316095.756",
                            "Northing":"234517.835",
                            "physical_condition": "High"]
     
        let minimalStand = BikeStand(csvLineDict: minimalStandDict)
        
        XCTAssertEqual(minimalStand.typeStands, TypeStands.SheffieldStand)
        XCTAssertEqual(minimalStand.location.longitude, CLLocationDegrees(-6.257431358))
        XCTAssertEqual(minimalStand.location.latitude, CLLocationDegrees(53.34837783))
        XCTAssertEqualWithAccuracy(minimalStand.easting, 316095.756, accuracy: 5)
        XCTAssertEqualWithAccuracy(minimalStand.northing, 234517.835, accuracy: 5)
        XCTAssertEqual(minimalStand.physicalCondition, PhysicalCondition.High)
    }
    
    func testMaxBikeStand() {
        
        let maxStandDict = ["type_stands" : "Sheffield Stand",
                            "X" : "-6.265138686",
                            "Y" : "53.33424783",
                            "Easting" : "315620.753",
                            "Northing" : "232932.916",
                            "location_stand" : "Camden street lower, outside centra shop",
                            "no_stands" : "1",
                            "physical_condition" : "High",
                            "occupancy" : "50",
                            "expanded_capacity" :"1000",
                            "security_safetyrating" : "High",
                            "lighting" : "High",
                            "protection_weather" : "Low",
                            "large_development" : "All",
                            "ease_access" : "Good",
                            "proximity_cyclenetwork" : "Visible",
                            "commercial" : "Yes",
                            "retail" : "Yes",
                            "residential" : "Yes",
                            "transportation" : "Yes",
                            "education" : "Yes",
                            "recreational" : "Yes",
                            "entertainment" : "Yes",
                            "restaurants" : "Yes",
                            "expanded_stands" : "10"]
        
        let maxStand = BikeStand(csvLineDict: maxStandDict)
        
        XCTAssertEqual(maxStand.locationStand, "Camden street lower, outside centra shop")
    
        // TODO more assertions
    }
    
    func testAnnotationTitle() throws {
        
        let data = BSData()
        
        // Read in the file
        let bundle = NSBundle(forClass: self.classForCoder)
        //let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("cycle-final-07032016", ofType: "csv")!
        
        let content = try String(contentsOfFile: path)
        
        let bikeStands = data.parseCsv(content)
        
        // Typical Sheffield stands
        XCTAssertEqual(bikeStands[0].annotationTitle, "4 Sheffield stands")
        XCTAssertEqual(bikeStands[0].annotationSubTitle, "East wall road outside the O2")
        
        // Individual Sheffield stand
        XCTAssertEqual(bikeStands[3].annotationTitle, "Sheffield stand")
        XCTAssertEqual(bikeStands[3].annotationSubTitle, "Custom House Quay, outside AIB International Centre")
        
        // Stainless Steel Curved
        XCTAssertEqual(bikeStands[54].annotationTitle, "4 Stainless Steel Curved stands")
        XCTAssertEqual(bikeStands[54].annotationSubTitle, "George's Dock across the road from KPMG")
        
        // Railing
        XCTAssertEqual(bikeStands[55].annotationTitle, "Railing with space for 8")
        XCTAssertEqual(bikeStands[55].annotationSubTitle, "Suffolk street")
        
        // Railing with no space given
        // No case for this happening! 
        
        // If it's a hoop, just say hoop
        XCTAssertEqual(bikeStands[321].annotationTitle, "Cycle-hoop")
        XCTAssertEqual(bikeStands[321].annotationSubTitle, "Parnell Street outside Centra")
        
        // For blank subtitle
        XCTAssertEqual(bikeStands[324].annotationTitle, "Cycle-hoop")
        XCTAssertEqual(bikeStands[324].annotationSubTitle, nil)   
    }
}
