//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Ryan Rottmann on 5/10/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    var addTripTitle: String? {
        get{
            return tripTitle as String?
        }
        set {
            tripTitle = newValue as String?
        }
    }
    
    convenience init?(tripTitle: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext, !tripTitle.isEmpty else{
            return nil
        }
        self.init(entity: Trip.entity(), insertInto: managedContext)
        self.tripTitle = tripTitle
        
    }
}
