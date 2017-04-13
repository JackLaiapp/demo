//
//  ViewController.swift
//  demo6
//
//  Created by MyMac on 2017/3/27.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {


    
    var locationManager = CLLocationManager()

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let url = URL(string: "https://api.foursquare.com/v2/venues/search?ll=25.0340,121.5645&client_secret=K0VEJOJAWF22ZLFE4JB1UKAA30EQIJLIRYBLPRVBGAWCIF21&client_id=WAZRE5S01OKL5BDJKZT1PUPZMFJ00T5NAM5QUJHTYYO4DKNO&v=30000101")
        let urlRequest = URLRequest(url: url!, cachePolicy:.returnCacheDataElseLoad, timeoutInterval: 30)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data:Data?, response:URLResponse?, err:Error?) -> Void in
            guard err == nil else {
                return
            }
            if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options:
                        []) as? [String:Any]
                    let responseDic = dic?["response"] as? [String:Any]
                    let array = responseDic?["venues"] as? [[String:Any]]
                    if let array = array {
                        for venue in array {
                            print("\(venue["name"]!)  \(venue["location"]!)")
                        } }
                }
                catch {
                }
            } }
        task.resume()
    }
    
    // Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! nameTableViewCell
        
        cell.nameLabel.text = self.v
        return cell
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

