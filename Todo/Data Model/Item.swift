//
//  Item.swift
//  Todo
//
//  Created by Eun Su Shim on 2018-08-16.
//  Copyright © 2018 Eun Su Shim. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
