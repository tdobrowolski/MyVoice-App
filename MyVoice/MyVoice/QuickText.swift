//
//  QuickText.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 27.01.2017.
//  Copyright © 2017 Infinite. All rights reserved.
//

import Foundation
import RealmSwift

class QuickText: Object {
    
    dynamic var text = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
