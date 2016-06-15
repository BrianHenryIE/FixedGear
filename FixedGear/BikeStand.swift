//
//  BikeStand.swift
//  FixedGear
//
//  Created by Brian Henry on 13/06/2016.
//  Copyright © 2016 Brian Henry. All rights reserved.
//

import Foundation
import MapKit

enum TypeStands : String {
    case SheffieldStand = "Sheffield Stand", Railing, StainlessSteelCurved = "Stainless Steel Curved", Hoops
}

enum PhysicalCondition : String {
    case High, Medium
}

enum SecuritySafetyrating : String {
    case High, Medium
}

enum Lighting : String {
    case High, Medium, Low
}

enum ProtectionWeather : String {
    case High, Medium, Low
}

enum LargeDevelopment : String {
    case All
}

enum EaseAccess : String {
    case Fair, Good, Poor
}

enum ProximityCyclenetwork : String {
    case AdjacentVisible, Unknown, Visible
}

struct BikeStand {

    let typeStands : TypeStands
    let location : CLLocationCoordinate2D
    let easting : Double
    let northing : Double
    let locationStand : String?
    let noStands : Int?
    let physicalCondition : PhysicalCondition
    let occupancy : Int?
    let expandedCapacity : Int?
    let securitySafetyrating : SecuritySafetyrating?
    let lighting : Lighting?
    let protectionWeather : ProtectionWeather?
    let largeDevelopment : LargeDevelopment?
    let easeAccess : EaseAccess?
    let proximityCyclenetwork : ProximityCyclenetwork?
    let commercial : Bool?
    let retail: Bool?
    let residential : Bool?
    let transportation : Bool?
    let education : Bool?
    let recreational : Bool?
    let entertainment : Bool?
    let restaurants : Bool?
    let expandedStands : Int?

    init(csvLineDict : [String : String]) {
    
        typeStands = TypeStands(rawValue: csvLineDict["type_stands"]!)!
        let x = (csvLineDict["X"]! as NSString).doubleValue
        let y = (csvLineDict["Y"]! as NSString).doubleValue
        location = CLLocationCoordinate2D(latitude: y, longitude: x)
        easting = (csvLineDict["Easting"]! as NSString).doubleValue
        northing = (csvLineDict["Northing"]! as NSString).doubleValue
        locationStand = csvLineDict["location_stand"] == "" ? nil : csvLineDict["location_stand"]
        
        noStands = csvLineDict["no_stands"] == nil ? nil : Int(csvLineDict["no_stands"]!)

        physicalCondition = PhysicalCondition(rawValue: csvLineDict["physical_condition"]!)!
        
        occupancy = csvLineDict["occupancy"] == nil ? nil : Int(csvLineDict["occupancy"]!)

        expandedCapacity = csvLineDict["expanded_capacity"] == nil ? nil : Int(csvLineDict["expanded_capacity"]!)
        
        securitySafetyrating = csvLineDict["security_safetyrating"] == nil ? nil : SecuritySafetyrating(rawValue: csvLineDict["security_safetyrating"]!)
        
        lighting = csvLineDict["lighting"] == nil ? nil : Lighting(rawValue: csvLineDict["lighting"]!)
        
        protectionWeather = csvLineDict["protection_weather"] == nil ? nil : ProtectionWeather(rawValue: csvLineDict["protection_weather"]!)
        
        largeDevelopment = csvLineDict["large_development"] == nil ? nil : LargeDevelopment(rawValue: csvLineDict["large_development"]!)
        
        easeAccess = csvLineDict["ease_access"] == nil ? nil :EaseAccess(rawValue: csvLineDict["ease_access"]!)
        
        proximityCyclenetwork = csvLineDict["proximity_cyclenetwork"] == nil ? nil : ProximityCyclenetwork(rawValue: csvLineDict["proximity_cyclenetwork"]!)

        commercial = (csvLineDict["commercial"] == "Yes" ? true : nil)
        retail = (csvLineDict["retail"] == "Yes" ? true : nil)
        residential = (csvLineDict["residential"] == "Yes" ? true : nil)
        transportation = (csvLineDict["transportation"] == "Yes" ? true : nil)
        education = (csvLineDict["education"] == "Yes" ? true : nil)
        recreational = (csvLineDict["recreational"] == "Yes" ? true : nil)
        entertainment = (csvLineDict["entertainment"] == "Yes" ? true : nil)
        restaurants = (csvLineDict["restaurants"] == "Yes" ? true : nil)
        expandedStands = csvLineDict["expanded_stands"] == nil ? nil : Int(csvLineDict["expanded_stands"]!)
    }

    var annotationTitle : String? {
        get {
            switch typeStands {
            case .Hoops:
                return "Cycle-hoop"
            case .Railing:
                return "Railing with space for \(expandedStands!)"
            case .SheffieldStand:
                if let noStands = noStands {
                    if (noStands == 1) {
                        return "Sheffield stand"
                    } else {
                        return "\(noStands) Sheffield stands"
                    }
                } else {
                    return "Sheffields stand(s)"
                }
            case .StainlessSteelCurved:
                return "\(noStands!) Stainless Steel Curved stands"
            }
        }
    }
    
    var annotationSubTitle : String? {
        get {
            return locationStand
        }
    }
}
