//
//  App.swift
//  RappStore
//
//  Created by Bryan A Bolivar M on 10/24/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit

class App: NSObject {
    var category: Category!
    var image: String!
    var name: String!
    var price: String!
    var artist: String!
    var summary: String!
    var title: String!
    var link: NSURL!
    
    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        //getting the latest image is the biggest one of the current array
        image = ((dictionary["im:image"] as! NSArray).object(at: (dictionary["im:image"] as! NSArray).count - 1) as! NSDictionary).object(forKey: "label") as! String
        title = (dictionary["title"] as! NSDictionary).object(forKey: "label") as! String
        link = NSURL(string: ((dictionary["link"] as! NSDictionary).object(forKey: "attributes") as! NSDictionary).object(forKey: "href") as! String)
        summary = (dictionary["summary"] as! NSDictionary).object(forKey: "label") as! String
        name = (dictionary["im:name"] as! NSDictionary).object(forKey: "label") as! String
        artist = (dictionary["im:artist"] as! NSDictionary).object(forKey: "label") as! String
        
        //getting price of the app
        let currency = ((dictionary["im:price"] as! NSDictionary).object(forKey: "attributes") as! NSDictionary).object(forKey: "currency") as! String
        let amount = ((dictionary["im:price"] as! NSDictionary).object(forKey: "attributes") as! NSDictionary).object(forKey: "amount") as! String
       
        price = amount + " " + currency
        category = Category(dictionary["category"] as! Dictionary<String, AnyObject>)
    }
}
