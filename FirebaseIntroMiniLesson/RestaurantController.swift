//
//  RestaurantController.swift
//  FirebaseIntroMiniLesson
//
//  Created by Jordan Nelson on 2/29/16.
//  Copyright © 2016 Jordan Nelson. All rights reserved.
//

import Foundation
import Firebase

public let RestaurantsUpdatedNotification = "RestaurantsUpdatedNotificationName"

class RestaurantController {
    
    static let sharedController = RestaurantController()
    
    var restaurants:[Restaurant] {
        didSet {
            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName(RestaurantsUpdatedNotification, object: self)
        }
    }
    
    init() {
        self.restaurants = []
        loadRestaurants()
    }
    
    func loadRestaurants() {
        
        let allRestaurantsRef = FirebaseController.restaurantBase
        allRestaurantsRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
            
            if let restaurantDictionaries = snapshot.value as? [[String:AnyObject]] {
                self.restaurants = restaurantDictionaries.flatMap({Restaurant(dictionary: $0)})
            }
        })
    }
    
    func addRestaurant(restaurant:Restaurant) {
        restaurants.append(restaurant)
        saveToFirebase()
    }
    
    func saveToFirebase() {
        let restaurantDictionaries = self.restaurants.map({$0.dictionaryCopy()})
        FirebaseController.restaurantBase.setValue(restaurantDictionaries)
    }
    
}


