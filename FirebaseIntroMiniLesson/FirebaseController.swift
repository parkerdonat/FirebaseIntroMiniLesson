//
//  FirebaseController.swift
//  FirebaseIntroMiniLesson
//
//  Created by Parker Donat on 2/29/16.
//  Copyright © 2016 Jordan Nelson. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let base = Firebase(url: "https://local-restaurant.firebaseio.com")
    static let restaurantsRef = base.childByAppendingPath("Restaurants")
    
    
}

