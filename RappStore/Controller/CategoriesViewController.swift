//
//  CategoriesViewController.swift
//  RappStore
//
//  Created by Bryan A Bolivar M on 10/24/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit
import CoreData
class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var apps = [NSManagedObject]()
    var categoriesArray:NSArray! = []
    var selectedCategory = ""
    var selectedApps:[App]! = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiRequests.getAppList { (apps) in 
            RappManager.getApplicationsByCategories(completion: { (categories) in
                print(categories)
                self.categoriesArray = categories
                self.tableView.reloadData()
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AppSegue") {
            let viewController:ApplicationViewController = segue.destination as! ApplicationViewController
            viewController.title = self.selectedCategory
            viewController.apps = self.selectedApps
        }
    }
    
    //MARK: - GET METHODS

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCategory = ((categoriesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "category") as? String)!
        self.selectedApps = (categoriesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "apps") as! [App]
        self.performSegue(withIdentifier: "AppSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        //let app = apps[indexPath.row]
        
        cell.labelName.text =  (categoriesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "category") as? String
        
        let x = ((categoriesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "apps") as? NSArray)?.count
        cell.labelAppCount.text = "\(x!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoriesArray.count
    }
}
