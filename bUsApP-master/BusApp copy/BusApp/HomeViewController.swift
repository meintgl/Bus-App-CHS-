//
//  HomeViewController.swift
//  BusApp
//
//  Created by Meinhard Benedict Capucao on 11/12/19.
//  Copyright © 2019 Meinhard Benedict Capucao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {

    //MARK: - Properties
 
    var locationManager: CLLocationManager!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
     
        
    }
    
    
    
    // MARK: - HELPER FUNCTIONS
    
    func configureMapView() {
        
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        view.addSubview(mapView)
        
        
    }


      
    }



    



    

