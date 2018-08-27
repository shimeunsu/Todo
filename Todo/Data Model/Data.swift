//
//  Data.swift
//  Todo
//
//  Created by Eun Su Shim on 2018-08-13.
//  Copyright © 2018 Eun Su Shim. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object{
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
    
}
