//
//  CustomAnnotation.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-09.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import Foundation
import MapKit

let parks = ["green park", "blue park", "river park", "mountainview park"]

class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var customNumber: Int
    var customName = String()
    var title:String?
    
    
    init(coordinate:CLLocationCoordinate2D, customNumber: Int) {
        
        self.coordinate = coordinate
        self.customNumber = customNumber
        self.customName = parks[customNumber - 1].capitalized
        self.title = self.customName
        
    }
    
}
