//
//  ViewControllersManager.swift
//  Location
//
//  Created by Alina Nanu on 28.12.2020.
//

import Foundation
import UIKit

class ViewControllersManager: NSObject {
    
    static let shared = ViewControllersManager()
    var navController: GeneralNavigationController!
    
    func rootViewController() -> UIViewController {
        let vc = LocationsViewController()
        
        self.navController = GeneralNavigationController(rootViewController: vc)
        
        return self.navController
    }
}
