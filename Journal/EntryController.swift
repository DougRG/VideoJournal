//
//  EntryController.swift
//  Journal
//
//  Created by Douglas Goodwin on 12/2/15.
//  Copyright © 2015 Dr.G. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedController = EntryController()
    
    var entries: [Entry] {
        
        let request = NSFetchRequest(entityName: "Entry")
        
        do {
            return try Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as! [Entry]
        } catch {
            return []
        }
    }
    
    func addEntry(entry: Entry) {
        
        saveToPersistentStorage()
    }
    
    func removeEntry(entry: Entry) {
        
        entry.managedObjectContext?.deleteObject(entry)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved.")
        }
    }
    
}