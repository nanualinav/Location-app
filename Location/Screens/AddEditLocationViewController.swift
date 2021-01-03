//
//  AddEditLocationViewController.swift
//  Location
//
//  Created by Alina Nanu on 31.12.2020.
//

import UIKit
import RealmSwift

class AddEditLocationViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var lngTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    // properties
    var location: Location?
    var isEditingScreen: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.customize()
        self.refreshUI()
    }
    
    func customize() {
        self.title = self.isEditingScreen == true ? "Edit Location" : "Add Location"
        self.saveButton.setTitle(self.isEditingScreen == true ? "Update" : "Save", for: .normal)
    }
    
    func cleanData() {
        self.latTextField.text = ""
        self.lngTextField.text = ""
        self.addressTextField.text = ""
        self.labelTextField.text = ""
    }
    
    func refreshUI() {
        if self.isEditingScreen == true {
            self.latTextField.text = "\(self.location?.lat ?? 0.0)"
            self.lngTextField.text = "\(self.location?.lng ?? 0.0)"
            self.labelTextField.text = self.location?.label
            self.addressTextField.text = self.location?.address
        }
    }
    
    func validateFields() -> Bool {
        if self.lngTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            self.show(message: "Longitude cannot be empty", title: nil)
            return false
        }
        
        if self.latTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            self.show(message: "Latitude cannot be empty", title: nil)
            return false
        }
        
        if self.labelTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            self.show(message: "Label cannot be empty", title: nil)
            return false
        }
        
        if self.addressTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            self.show(message: "Address cannot be empty", title: nil)
            return false
        }
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func onSave(_ sender: Any) {
        let realm = try! Realm()
        
        if self.validateFields() {
            if self.isEditingScreen == true {
                self.location?.lat = Double(self.latTextField.text ?? "") ?? 0.0
                self.location?.lng = Double(self.lngTextField.text ?? "") ?? 0.0
                self.location?.label = self.labelTextField.text ?? ""
                self.location?.address = self.addressTextField.text ?? ""

                // Updating book with id = 1
                try! realm.write {
                    realm.add(self.location ?? Location())
                    self.cleanData()
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                let newLocation = Location()
                
                newLocation.lat = Double(self.latTextField.text ?? "") ?? 0.0
                newLocation.lng = Double(self.lngTextField.text ?? "") ?? 0.0
                newLocation.label = self.labelTextField.text ?? ""
                newLocation.address = self.addressTextField.text ?? ""
                
                try! realm.write {
                    realm.add(newLocation)
                    self.cleanData()
                    self.navigationController?.popViewController(animated: true)
                }
            }
           
        }
    }
}
