//
//  GiveneraCurrentUser.swift
//  Baseline
//
//  Created by hersh amin on 12/6/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import Foundation

class GiveneraCurrentUser {
    
    // Singleton initialization
    class var sharedUser: GiveneraCurrentUser {
        struct Static {
            static let instance = GiveneraCurrentUser()
        }
        return Static.instance
    }
    
    // Variables to store
    internal var authToken:String!
    internal var userID:String!
    internal var fullName:String!
    internal var profilePic:String!    
}