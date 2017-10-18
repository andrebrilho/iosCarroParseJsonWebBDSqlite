//
//  MapViewController.swift
//  Carros
//
//  Created by André Brilho on 23/12/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let locManager = CLLocationManager()
    var carro:Carro?
    @IBOutlet var mapView:MKMapView!
    var pin = MKPointAnnotation()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.mapView.mapType = MKMapType.Hybrid
        locManager.requestWhenInUseAuthorization()
        if(carro != nil){
            //latitude e longitusw
            let lat = (self.carro!.latitude as NSString).doubleValue
            let lng = (self.carro!.longitude as NSString).doubleValue
            print("LAT ->",lat)
            print("LON ->",lng)
            //Cordenadas
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let location = MKCoordinateRegion(center: center, span: span)
            self.mapView.setRegion(location, animated: true)
            
            pin.coordinate = location.center
            pin.title = "Fábrica da \(self.carro!.nome)"
            self.mapView.addAnnotation(pin)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
        pinView.pinTintColor = UIColor.redColor()
        pinView.canShowCallout = true
        let btPin = UIButton(type: .DetailDisclosure) as UIView
        pinView.rightCalloutAccessoryView = btPin
        return pinView
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        Alerta.alerta("Opa !", viewController: self)
    }
    
}
