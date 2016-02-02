//
//  Entry.swift
//  Journal
//
//  Created by Douglas Goodwin on 12/2/15.
//  Copyright © 2015 Dr.G. All rights reserved.
//


import Foundation
import CoreData


class Entry: NSManagedObject {
    
    convenience init(title: String, text: String, timestamp: NSDate = NSDate(), videoClip: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Entry", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.videoClip? = videoClip
        self.title = title
        self.text = text
        self.timestamp = timestamp
        
    }
}