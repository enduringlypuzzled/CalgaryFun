//
//  ViewController.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-05.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit

class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
   override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    

        /*Database stuff - create user write user stuff
        let id : String = "Stevo"
        let user : String = "user"
        let userData = ["provider": user.providerID]
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)*/
    
        //Initialize listener for database changes 
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            print(snapshot.value)
        
        })
    
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
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
   

}

