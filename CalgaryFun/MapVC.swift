//
//  MapVC.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-06.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase


class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false;
    
    //GEOFIRE
    var geoFire: GeoFire!
    var geoFireRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow

        //Refer to a firebase database reference
        geoFireRef = FIRDatabase.database().reference()
        geoFire = GeoFire(firebaseRef:geoFireRef)
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

    
    
    //Function that shows the locations on map
    func showSightingsOnMap(location:CLLocation){
        let circleQuery = geoFire!.query(at: location, withRadius: 2.5)
        
        _ = circleQuery?.observe(GFEventType.keyEntered, with: {(key, location) in
            
            if let key = key, let location = location {
                let anno = CustomAnnotation(coordinate: location.coordinate, pokemonNumber: Int(key)!)
                self.mapView.addAnnotation(anno)
                
            }
            
            
        })
        
    }

    

    //Update map when region changes to show annotations
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            showSightingsOnMap(location: loc)
    }
    
    
    //Show travelling directions to custom annotation if you click on that custom annotation
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let anno = view.annotation as? CustomAnnotation {
            
            var place:MKPlacemark!
            
            if #available(iOS 10.0, *){
                place = MKPlacemark(coordinate: anno.coordinate)
            } else {
                place = MKPlacemark(coordinate: anno.coordinate, addressDictionary: nil)
                
            }
            
            let destination = MKMapItem(placemark: place)
            destination.name = "Calgary Fun"
            let regionDistance:CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey:  NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving] as [String : Any]
            
            
            MKMapItem.openMaps(with:[destination], launchOptions: options)
            
        }
    }

    
    
    //Set Location whenever you see a Pokemon and set the GPS Location
    func createSighting(forLocation location: CLLocation, withPokemon pokeId:Int){
        geoFire.setLocation(location, forKey: "\(pokeId)")
        print("pokeid: \(pokeId)")
    }


   
    //Create custom annotation for the user
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annoIdentifier = "parks"
        var annotationView:MKAnnotationView?
        
        if annotation.isKind(of: MKUserLocation.self){
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named:"ash")
            
        }else if let deqAnno = mapView.dequeueReusableAnnotationView(withIdentifier: annoIdentifier) {
            annotationView = deqAnno
            annotationView?.annotation = annotation
        }else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView, let anno = annotation as? CustomAnnotation{
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "\(anno.pokemonNumber)")
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn.setImage(UIImage(named:"map"), for: .normal)
            annotationView.rightCalloutAccessoryView = btn
        }
        
        return annotationView
    }
    
    @IBAction func spotRandomPokemon(_ sender: AnyObject) {
       let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        let rand = arc4random_uniform(5) + 1
        
        createSighting(forLocation: loc, withPokemon: Int(rand))
        
        print("BUTTON PUSHED")
    }

    

   
}
