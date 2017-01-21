//
//  Books+CoreDataProperties.swift
//  ListWithCoreData
//
//  Created by Walid Sassi on 21/01/2017.
//  Copyright © 2017 Walid Sassi. All rights reserved.
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books");
    }

    @NSManaged public var bookName: String?

}
