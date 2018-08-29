//
//  Category.swift
//  Todo
//
//  Created by Eun Su Shim on 2018-08-16.
//  Copyright © 2018 Eun Su Shim. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
