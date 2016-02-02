//
//  Entry+CoreDataProperties.swift
//  Journal
//
//  Created by Douglas Goodwin on 12/2/15.
//  Copyright © 2015 Dr.G. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entry {

    @NSManaged var text: String?
    @NSManaged var timestamp: NSDate?
    @NSManaged var title: String?
    @NSManaged var videoClip: String?

}
