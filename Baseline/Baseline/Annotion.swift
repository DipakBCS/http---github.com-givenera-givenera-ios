//
//  Annotion.swift
//  Baseline
//
//  Created by Bharti Softech on 12/19/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import Foundation

import MapKit

class Annotation: NSObject, MKAnnotation {
   // let title: String
    let star: String
    let appriationID: String
    let index: Int
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D , index:Int,star:String ,appriationID:String)
    {
        self.index = index
        self.star = star
        self.appriationID = appriationID
        self.coordinate = coordinate
        super.init()
    }
    
}