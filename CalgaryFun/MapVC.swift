//
//  MapVC.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-06.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit
import MapKit


class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        // Do any additional setup after loading the view.
    }
    
    
    //Map stuff
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    
    //Authorize the user's location only when app is being used
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
            
        //Ask for user's authorization if haven't already
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    
    }
    
    //When user says yes, this function is called to get user's infor
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse  {
            mapView.showsUserLocation = true
        }
    }
    
    //function to center map on user's location
    func centerMapOnLocation(location:CLLocation){
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let loc = userLocation.location {
            
            if !mapHasCenteredOnce {
                centerMapOnLocation(location: loc)
                mapHasCenteredOnce = true
            }
            
        }
    }
    
   /* //Create custom annotation for the user
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = MKAnnotationView?()
        
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named:"me")
        }
        

        return annotationView
    }*/
    
    
    
    

   
}
