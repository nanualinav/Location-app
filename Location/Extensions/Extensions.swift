//
//  Extensions.swift
//  Location
//
//  Created by Alina Nanu on 28.12.2020.
//

import Foundation
import UIKit
import CoreLocation

extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}

import CoreLocation

extension CLLocationCoordinate2D {

    func distanceFrom(otherCoord : CLLocationCoordinate2D) -> CLLocationDistance {
        let firstLoc = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let secondLoc = CLLocation(latitude: otherCoord.latitude, longitude: otherCoord.longitude)
        return firstLoc.distance(from: secondLoc)
    }

}

extension UIViewController {
    
    typealias actionHandler = ((UIAlertAction) -> Void)
    
    func show(message: String?, title: String?, handler: actionHandler? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(error: Error, handler: actionHandler? = nil) {
        self.show(message: "There was an error", title: "Error")
    }
}

public extension String {
    func isNumber() -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
        
    }
}
