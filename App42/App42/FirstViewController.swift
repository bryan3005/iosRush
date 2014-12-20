//
//  FirstViewController.swift
//  App42
//
//  Created by Bryan Pro on 20/12/14.
//  Copyright (c) 2014 Bryan Pro. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var coo_x = 0.0
var coo_y = 0.0

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    

    @IBOutlet weak var Control: UISegmentedControl!
   

    var locationManager = CLLocationManager()
 

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map.mapType = MKMapType.Satellite
        var x_coor = 48.896800
        var y_coor = 2.318387
        var centerLocation = CLLocationCoordinate2DMake(48.896800, 2.318387)
        
        var mapSpan = MKCoordinateSpanMake(0.003, 0.003)
        
        var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
        
        self.map.setRegion(mapRegion, animated: true)
        
        var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(48.896652, 2.318376)
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "42 School"
        objectAnnotation.subtitle = "Cybercafé, Hotel, Cinéma"
        self.map.addAnnotation(objectAnnotation)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            var objectAnnotation2 = MKPointAnnotation()
           map.removeAnnotations(map.annotations)
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            println(locality)
            println(postalCode)
            println(administrativeArea)
            println(country)
            println(containsPlacemark.location.coordinate.latitude)
            println(containsPlacemark.location.coordinate.longitude)
            var centerLocation2 = CLLocationCoordinate2DMake(containsPlacemark.location.coordinate.latitude,containsPlacemark.location.coordinate.longitude)

            
            // var mapSpan2 = MKCoordinateSpanMake(0.003, 0.003)
            
             var mapRegion2 = MKCoordinateRegionMake(centerLocation2,  MKCoordinateSpanMake(0.003, 0.003))
            
             self.map.setRegion(mapRegion2, animated: true)
            //try
            var pinLocation2 : CLLocationCoordinate2D = CLLocationCoordinate2DMake(containsPlacemark.location.coordinate.latitude, containsPlacemark.location.coordinate.longitude)
            //var objectAnnotation2 = MKPointAnnotation()
            objectAnnotation2.coordinate = pinLocation2
            objectAnnotation2.title = locality
            objectAnnotation2.subtitle = postalCode + " " + administrativeArea + " " + country
                        self.map.addAnnotation(objectAnnotation2)
            //try
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    @IBAction func FindMyLocation(sender: AnyObject) {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        //var centerLocation2 = CLLocationCoordinate2DMake(coo_x,coo_y)
       // println(coo_x)
       // println(coo_y)
       // var mapSpan2 = MKCoordinateSpanMake(0.003, 0.003)
        
       // var mapRegion2 = MKCoordinateRegionMake(centerLocation2, mapSpan2)
        
       // self.map.setRegion(mapRegion2, animated: true)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func ChangeModeMap(sender: AnyObject)
    {
        
        if Control.selectedSegmentIndex == 0
        {
            map.mapType = MKMapType.Standard
        }
        else if Control.selectedSegmentIndex == 1
        {
            map.mapType = MKMapType.Satellite
        }
        else
        {
            map.mapType = MKMapType.Hybrid
        }
    }

    

//try
    
}

