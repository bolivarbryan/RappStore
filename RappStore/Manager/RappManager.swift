//
//  RappManager.swift
//  RappStore
//
//  Created by Bryan A Bolivar M on 10/24/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit
import CoreData
class RappManager: NSObject {
    class func getApplications () {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        // Initialize Fetch Request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Application")
        
        let context = appdelegate.persistentContainer.viewContext
        
        request.returnsObjectsAsFaults = false
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Application", in: ApiRequests.getContext() )
        
        // Configure Fetch Request
        request.entity = entityDescription
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0{
                for result in results {
                    print(result)
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
    }
}
