//
//  Data.swift
//  FixedGear
//
//  Created by Brian Henry on 14/06/2016.
//  Copyright © 2016 Brian Henry. All rights reserved.
//

import Foundation
import SwiftCSV
import MapKit

class BSData {
    
    var bikeStands : [BikeStand]!
    
    init(){
        
        // Read in the file
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("cycle-final-07032016", ofType: "csv")!
        
        do {
            let content = try String(contentsOfFile: path)
            bikeStands = parseCsv(content)
        } catch {
            bikeStands = [BikeStand]()
            // TODO: something
        }
    }
    
    func parseCsv(csvAsString : String) -> [BikeStand] {
        
        let csv = CSV(string: csvAsString)
        
        var bikeStands = [BikeStand]()
        
        // Access them as a dictionary
        csv.enumerateAsDict { dict in
            bikeStands.append(BikeStand(csvLineDict: dict))
        }
        
        return bikeStands
    }
    
    func findMaxLatPoint(coordinates: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        var maxLat : CLLocationCoordinate2D = coordinates[0]
        for coordinate in coordinates {
            if(maxLat.latitude < coordinate.latitude) {
                maxLat = coordinate
            }
        }
        return maxLat
    }

    func findMinLatPoint(coordinates: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        var minLat : CLLocationCoordinate2D = coordinates[0]
        for coordinate in coordinates {
            if(minLat.latitude > coordinate.latitude) {
                minLat = coordinate
            }
        }
        return minLat
    }
    
    func findMaxLongPoint(coordinates: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        var maxLong : CLLocationCoordinate2D = coordinates[0]
        for coordinate in coordinates {
            if(maxLong.longitude < coordinate.longitude) {
                maxLong = coordinate
            }
        }
        return maxLong
    }
    
    func findMinLongPoint(coordinates: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        var minLong : CLLocationCoordinate2D = coordinates[0]
        for coordinate in coordinates {
            if(minLong.longitude > coordinate.longitude) {
                minLong = coordinate
            }
        }
        return minLong
    }

    // Bug: These calculations don't work over the international date line!
    func isLocationWithinSquareArea(areaCoordinates: [CLLocationCoordinate2D], location: CLLocationCoordinate2D) -> Bool {
        
        if(location.longitude < findMinLongPoint(areaCoordinates).longitude || location.longitude > findMaxLongPoint(areaCoordinates).longitude) {
            return false
        }
        if(location.latitude < findMinLatPoint(areaCoordinates).latitude || location.latitude > findMaxLatPoint(areaCoordinates).latitude) {
            return false
        }
        return true
    }
    
    func isLocationWithinBikeStandsArea(location : CLLocationCoordinate2D) -> Bool {
        
        let coordinates: [CLLocationCoordinate2D] = bikeStands.map { return $0.location }
        
        return isLocationWithinSquareArea(coordinates, location: location)
    }
    
}