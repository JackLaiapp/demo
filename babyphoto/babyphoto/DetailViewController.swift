//
//  DetailViewController.swift
//  babyphoto
//
//  Created by MyMac on 2017/4/13.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit
import MapKit
import Social
class DetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var showPhoto: UIImageView!
    @IBOutlet var showLabel: UILabel!
    @IBOutlet var showMap: MKMapView!
    var myData : Info!

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = showPhoto.image
        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.pinTintColor = UIColor.orange
        
        return annotationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showdata()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            let controller = segue.destination as! AddViewController
            
            controller.myData = myData
        
    }
    override func viewWillAppear(_ animated: Bool) {
        showdata()
    }
    
    func showdata(){
        showPhoto.image = UIImage(data: myData.image as! Data)
        showLabel.text = myData.date! + " " + myData.title!
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(myData.location!, completionHandler: { placemarks, error in
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.myData.location
                //annotation.subtitle = "醫院"
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation
                    self.showMap.showAnnotations([annotation], animated: true)
                    self.showMap.selectAnnotation(annotation, animated: true)
                }
            }
        })
        
        showMap.delegate = self
        showMap.showsCompass = true
        showMap.showsScale = true
        showMap.showsTraffic = true
    }

    @IBAction func post(_ sender: Any) {

        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            if let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook){
                fbComposer.setInitialText(showLabel.text)
                fbComposer.add(showPhoto.image)
                present(fbComposer, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Ooops!", message: "Please login to your facebook", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: {
                (action) in
                if let settingURL = URL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
                }
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
