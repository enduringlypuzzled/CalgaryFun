//
//  Post.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-17.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _caption: String!
    private var _title: String!
    private var _address: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    

    var caption: String {
        return _caption
    }
    
    var address: String {
        return _address
    }
    
    var title: String {
        return _title
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(caption: String, address:String, title:String, imageUrl: String, likes: Int) {
        self._caption = caption
        self._address = address
        self._title = title
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    //Converts data we get from the databse into something we can use
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let address = postData["address"] as? String {
            self._address = address
        }
        
        if let title = postData["title"] as? String {
            self._title = title
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
            print("steve: found image")
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        //_postRef = DataService.ds.REF_POSTS.child(_postKey)
        
        
    }
    
}
