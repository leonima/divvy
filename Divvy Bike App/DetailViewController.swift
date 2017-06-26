//
//  DetailViewController.swift
//  Divvy Bike App
//
//  Created by Ziyun Ma on 6/26/17.
//  Copyright © 2017 Ziyun Ma. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var myMap: MKMapView!
    
    var detailItem:[String: String]!
       override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var centerLocation = CLLocationCoordinate2DMake(Double(detailItem["latitude"]!)!, Double(detailItem["longitude"]!)!)
        
        var mapSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = centerLocation
        
        self.myMap.setRegion(mapRegion, animated: true)
        self.myMap.addAnnotation(annotation)
        annotation.title = detailItem["stationName"]
        annotation.subtitle = detailItem["city"]
    }
}
