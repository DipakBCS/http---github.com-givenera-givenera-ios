//
//  GiveneraAppreciation.swift
//  Baseline
//
//  Created by hersh amin on 12/4/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import Foundation

class GiveneraAppreciation {
    
    
    class var sharedUser: GiveneraAppreciation
    {
        struct Static
        {
            static let instance = GiveneraAppreciation()
        }
        return Static.instance
    }
    
    // Variables to store
    internal var eventArray:NSMutableArray!
    
    internal var eventID:String!
    
    internal var eventDateStr:String!
    
    internal var eventDisc:String!
    
    internal var eventDate:NSDate!
    
    internal var employeeList:NSMutableArray!
    
    internal var employerList:NSMutableArray!
    
    internal var imageArray:NSArray!
    
    internal var eventCreator:String!
    
    
   
    
        
}