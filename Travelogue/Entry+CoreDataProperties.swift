//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Ryan Rottmann on 5/10/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var entryTitle: String?
    @NSManaged public var date: String?
    @NSManaged public var text: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var rawTrips: NSOrderedSet?

}

// MARK: Generated accessors for rawTrips
extension Entry {

    @objc(insertObject:inRawTripsAtIndex:)
    @NSManaged public func insertIntoRawTrips(_ value: Trip, at idx: Int)

    @objc(removeObjectFromRawTripsAtIndex:)
    @NSManaged public func removeFromRawTrips(at idx: Int)

    @objc(insertRawTrips:atIndexes:)
    @NSManaged public func insertIntoRawTrips(_ values: [Trip], at indexes: NSIndexSet)

    @objc(removeRawTripsAtIndexes:)
    @NSManaged public func removeFromRawTrips(at indexes: NSIndexSet)

    @objc(replaceObjectInRawTripsAtIndex:withObject:)
    @NSManaged public func replaceRawTrips(at idx: Int, with value: Trip)

    @objc(replaceRawTripsAtIndexes:withRawTrips:)
    @NSManaged public func replaceRawTrips(at indexes: NSIndexSet, with values: [Trip])

    @objc(addRawTripsObject:)
    @NSManaged public func addToRawTrips(_ value: Trip)

    @objc(removeRawTripsObject:)
    @NSManaged public func removeFromRawTrips(_ value: Trip)

    @objc(addRawTrips:)
    @NSManaged public func addToRawTrips(_ values: NSOrderedSet)

    @objc(removeRawTrips:)
    @NSManaged public func removeFromRawTrips(_ values: NSOrderedSet)

}
