//
//  Category.swift
//  RappStore
//
//  Created by Bryan A Bolivar M on 10/24/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit

class Category: NSObject {
    var label: String!
    var term: String!
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        super.init()
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        label = (dictionary["attributes"] as! NSDictionary).object(forKey: "label") as! String
        term = (dictionary["attributes"] as! NSDictionary).object(forKey: "term") as! String
    }
}
