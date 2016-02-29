//
//  RestaurantController.swift
//  FirebaseIntroMiniLesson
//
//  Created by Parker Donat on 2/29/16.
//  Copyright © 2016 Jordan Nelson. All rights reserved.
//

import Foundation
import Firebase

public let RestaurantsUpdatedNotification = "RestaurantsUpdatedNotificationName"

class RestaurantController {
    
    // Property of array of all the restaurants
    // Everytime the restaurant changes it will send a notification
    var restaurants: [Restaurant] {
        didSet {
            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName(RestaurantsUpdatedNotification, object: self)
        }
    }
    
    static let sharedController = RestaurantController()
    
    
    // reset those empty restaurants
    init() {
        self.restaurants = []
        loadRestaurants()
    }
    
    // Do the observer event type. Always be listening when it's loaded
    func loadRestaurants() {
        
        // Watch the value of these restaurants
        FirebaseController.restaurantsRef.observeEventType(FEventType.Value, withBlock: { (snapshot) -> Void in
            
            for restaurantDictionary in snapshot.children {
                if let restaurantSnap = restaurantDictionary as? FDataSnapshot, let unwrappedRestaurant = restaurantSnap.value as? [String: AnyObject] {
                    
                    if let restaurant = Restaurant(dictionary: unwrappedRestaurant) {
                        self.restaurants.append(restaurant)
                    }
                }
            }
        })
    }
    
    
    // add method to add to firebase
    func addRestaurant(restaurant: Restaurant) {
        
        let newRestaurantRef = FirebaseController.restaurantsRef.childByAutoId()
        
        // pass the restaurant dictinary copy method and set it for firebase
        newRestaurantRef.setValue(restaurant.dictionaryCopy())
    }
}