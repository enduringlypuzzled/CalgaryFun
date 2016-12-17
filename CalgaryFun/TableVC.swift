//
//  ViewController.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-05.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit
import Firebase

class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    

        /*Database stuff - create user write user stuff
        let id : String = "Stevo"
        let user : String = "user"
        let userData = ["provider": user.providerID]
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)*/

    DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
        //print(snapshot.value)
        
        if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
            for snap in snapshot {
                print("SNAP: \(snap)")
                if let postDict = snap.value as? Dictionary<String, AnyObject> {
                    
                    let key = snap.key
                    let post = Post(postKey: key, postData: postDict)
                    print("KEY: \(key)")
                    self.posts.append(post)
                }
            }
            
        }
    })

    tableview.reloadData()
    
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //performSegue(withIdentifier: "GotoMap", sender: nil)
     
    }

    
    //Tableivew stuff
    @IBOutlet weak var tableview: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       //let post = posts[indexPath.row]
        //print("Stevo: \(post.address)")
        
        
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
   

}

