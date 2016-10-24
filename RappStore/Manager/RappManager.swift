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
    
    
    class func getApplications (completion: ((_ result : [App] ) -> Void)?){
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        // Initialize Fetch Request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Application")
        
        let context = appdelegate.persistentContainer.viewContext
        
        request.returnsObjectsAsFaults = false
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Application", in: ApiRequests.getContext() )
        
        let sortDescriptor = NSSortDescriptor(key: "category", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors
        
        // Configure Fetch Request
        request.entity = entityDescription
        
        do {
            
            let results = try context.fetch(request)
            
            var apps = [App]()
            if results.count > 0 {
                for appObject in results as! [NSManagedObject] {
                    let app = App()
                    
                    app.name = appObject.value(forKeyPath: "name") as! String!
                    app.link = NSURL(string: appObject.value(forKeyPath: "link") as! String!)
                    app.image = appObject.value(forKeyPath: "image") as! String!
                    app.summary = appObject.value(forKeyPath: "summary") as! String!
                    app.price = appObject.value(forKeyPath: "price") as! String!
                    app.title = appObject.value(forKeyPath: "title") as! String!
                    app.artist = appObject.value(forKeyPath: "artist") as! String!
                    
                    let category = Category()
                    category.label = appObject.value(forKeyPath: "category") as! String!
                    category.term = appObject.value(forKeyPath: "category") as! String!
                    
                    app.category = category
                    apps.append(app)
                }
                
               completion!(apps)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        
    }
    /*
     [[category: "sports", apps: [App]]]
 
 */
    
    class func getApplicationsByCategories(completion: ((_ result : NSArray ) -> Void)?){
        var formattedArray = NSMutableArray()

       RappManager.getApplications { (apps) in

        for app in apps {
            print(app.name + ": " +  app.category.label)
            //ordering by categories
            
            var categoryFound = false
            //seaching category inside array
            var count = 0
            var indexFound = 0
            for category in formattedArray {
                // if category exists, add app on it
                print(category)
                if app.category.label == (category as! NSDictionary).object(forKey: "category") as! String {
                    categoryFound = true
                    indexFound = count
                }
                count += 1
            }
            
            if categoryFound == false {
               //create a new category
                let categoryDictionary = ["category": app.category.label, "apps": [app]] as [String : Any]
                
                formattedArray.add(categoryDictionary)
            }else{
                //append
                let appsFromCategory = NSMutableArray(array: (((formattedArray.object(at: indexFound)) as! NSDictionary).object(forKey: "apps") as! NSArray).copy() as! NSArray)
                
                appsFromCategory.add(app)
                
                let categoryDictionary = ["category": app.category.label, "apps": appsFromCategory.copy() as! [App]] as [String : Any]

                formattedArray.replaceObject(at: indexFound, with: categoryDictionary)
            }
        }
        //uncomment to see data structure
        //print(formattedArray)
        completion!(formattedArray)
        }
        
   

    }
    
    
    
   class func clearAllData() {

    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    // Initialize Fetch Request
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Application")
    
    let context = appdelegate.persistentContainer.viewContext
    
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

    let coord = appdelegate.persistentContainer.persistentStoreCoordinator

    do {
        try coord.execute(deleteRequest, with: context)
    } catch let error as NSError {
        debugPrint(error)
    }
    
    }
}
