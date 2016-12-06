//
//  ViewController.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-05.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit

class SigninVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
              print("steve: Hellow")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "GotoMap", sender: nil)
    
    }

   

}

