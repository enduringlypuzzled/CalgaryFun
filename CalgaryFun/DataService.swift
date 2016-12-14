//
//  DataService.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-13.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//
// This file is to get information from Database
import Foundation
import Firebase

//Global Declaration taken from GoogleService-Info.plist opposed to specifying URL
let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    static let ds = DataService()

    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }

    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    //Used to post data to Firebase Database
    func createFirebaseDBUser(uid:String, userData: Dictionary<String, String>) {
        
        //Write to users and pass UserData - does not wipe out existing data
        REF_USERS.child(uid).updateChildValues(userData)
        
    }

}
