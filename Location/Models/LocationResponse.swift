//
//  LocationResponse.swift
//  Location
//
//  Created by Alina Nanu on 28.12.2020.
//

import Foundation
import UIKit
import RealmSwift

struct LocationResponse: Codable {
    let status: String?
    let locations: [Location]?
}

class Location: Object, Codable {
    dynamic var lat: Double?
    dynamic var lng: Double?
    @objc dynamic var label: String?
    @objc dynamic var address: String?
    @objc dynamic var image: String?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
        case label = "label"
        case address = "address"
        case image = "image"
    }
}
