//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Ryan Rottmann on 5/10/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Entry)
public class Entry: NSManagedObject {
    var addEntryTitle: String? {
        get{
            return entryTitle as String?
        }
        set {
            entryTitle = newValue as String?
        }
    }
    
    convenience init?(entryTitle: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext, !entryTitle.isEmpty else{
            return nil
        }
        self.init(entity: Entry.entity(), insertInto: managedContext)
        self.entryTitle = entryTitle
        
    }}
