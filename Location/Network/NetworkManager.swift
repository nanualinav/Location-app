//
//  NetworkManager.swift
//  Location
//
//  Created by Alina Nanu on 28.12.2020.
//

import Foundation
import RealmSwift

final class NetworkManager {
    
    private var locations = [Location]()
    
    static func getLocations(completionHandler: @escaping ([Location]) -> Void) {
        let locationsUrl = "https://demo1042273.mockable.io/mylocations"
        
        guard let url = URL(string: locationsUrl) else {
                return
            }

         let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
           if let error = error {
             print("Error with fetching films: \(error)")
             return
           }
           
           guard let httpResponse = response as? HTTPURLResponse,
                 (200...299).contains(httpResponse.statusCode) else {
             print("Error with the response, unexpected status code: \(String(describing: response))")
             return
           }
            if let data = data,
                let l = try? JSONDecoder().decode(LocationResponse.self, from: data) {
                 completionHandler(l.locations ?? [])
             }
         })
         task.resume()
       }
}

