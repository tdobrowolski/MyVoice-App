//
//  Contacts.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 28.01.2017.
//  Copyright © 2017 Infinite. All rights reserved.
//

import Foundation
import RealmSwift

class Contacts: Object {
    
    dynamic var NameOne = ""
    dynamic var NameTwo = ""
    
    dynamic var phoneNumberOne = ""
    dynamic var phoneNumberTwo = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
