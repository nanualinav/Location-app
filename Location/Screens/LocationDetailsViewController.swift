//
//  LocationDetailsViewController.swift
//  Location
//
//  Created by Alina Nanu on 29.12.2020.
//

import UIKit
import Kingfisher

class LocationDetailsViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    
    // properties
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customize()
        self.refreshUI()
    }
    
    func customize() {
        self.title = "Location Details"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(onEditLocation))
    }
    
    func refreshUI() {
        self.locationImageView.kf.setImage(with: URL(string: self.location?.image ?? ""))
        self.addressLabel.text = "Address: \(self.location?.address ?? "N/A")"
        self.label.text = "Label: \(self.location?.label ?? "N/A")"
        self.coordinatesLabel.text = "Coordinates: Lat \(self.location?.lat ?? 0.0), Lng \(self.location?.lng ?? 0.0)"
        }
    
    // MARK: - Actions
    
    @objc func onEditLocation() {
        let vc = AddEditLocationViewController()
        vc.isEditingScreen = true
        vc.location = self.location
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
