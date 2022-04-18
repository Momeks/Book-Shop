//
//  Entity+CoreDataProperties.swift
//  Book Shop
//
//  Created by Momeks on 4/18/22.
//
//

import Foundation
import CoreData


extension Entity {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
		return NSFetchRequest<Entity>(entityName: "Entity")
	}
	
	@NSManaged public var coverURL: String?
	@NSManaged public var id: Int32
	
}

extension Entity : Identifiable {
	
}
