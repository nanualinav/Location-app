//
//  LocationsViewController.swift
//  Location
//
//  Created by Alina Nanu on 02.01.2021.
//

import UIKit
import FSPagerView
import Kingfisher
import CoreLocation
import RealmSwift
import Realm

class LocationsViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource, CLLocationManagerDelegate {
    
    let kCellIdentifier = "cell"
    
    //outlets
    @IBOutlet weak var pagerView: FSPagerView! {
    didSet {
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            }
        }
    
    // properties
       private var locations: [Location]?
       var locationManager: CLLocationManager!
       var myLocation: CLLocationCoordinate2D?
       let realm = try? Realm()
    

    override func viewDidLoad() {
           super.viewDidLoad()

           self.getLocations()
           self.customize()
       }
       
       func customize() {
           self.title = "Locations"
           self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
           
           if (CLLocationManager.locationServicesEnabled()) {
               locationManager = CLLocationManager()
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.requestAlwaysAuthorization()
               locationManager.startUpdatingLocation()
           }
           
           self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(onAddLocation))
       }
       
       // MARK: - Actions
       
       @objc func onAddLocation() {
           let vc = AddEditLocationViewController()
           self.navigationController?.pushViewController(vc, animated: true)
       }
       
       // MARK: - Realm
       
       func saveLocations() {
           try! self.realm?.write {
               self.locations?.forEach({ (l) in
                   realm?.add(l)
               })
           }
       }

       // MARK: - Server
       
       func getLocations() {
           NetworkManager.getLocations { (locations) in
               DispatchQueue.main.async {
                   self.locations = locations
                   //self.saveLocations()
                   self.pagerView.reloadData()
               }
           }
       }
       
       // MARK: - FSPagerViewDelegate, FSPagerViewDataSource
       
       func numberOfItems(in pagerView: FSPagerView) -> Int {
           return self.locations?.count ?? 0
       }
           
       public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
           
           let cell = pagerView.dequeueReusableCell(withReuseIdentifier: self.kCellIdentifier, at: index)
        
        let finalLocation = CLLocationCoordinate2D(latitude: self.locations?[index].lat ?? 0.0, longitude: self.locations?[index].lng ?? 0.0)
        let distance = finalLocation.distanceFrom(otherCoord: self.myLocation ?? CLLocationCoordinate2D()) / 1000
        
        cell.imageView?.kf.setImage(with: URL(string: self.locations?[index].image ?? ""))
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.text = "Address: \(self.locations?[index].address ?? "N/A"). Distance: \(String(format: "%.2f", distance)) km"
           
           return cell
       }
       
       func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
           pagerView.deselectItem(at: index, animated: true)
           
           let vc = LocationDetailsViewController()
           vc.location = self.locations?[index]
       
           self.navigationController?.pushViewController(vc, animated: true)
       }
       
       // MARK: - CLLocationManagerDelegate
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

           let locValue = manager.location!.coordinate
           self.myLocation = locValue
           print("loc value: \(locValue)")
       }
   }
