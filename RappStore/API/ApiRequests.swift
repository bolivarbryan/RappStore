//
//  ApiRequests.swift
//  RappStore
//
//  Created by Bryan A Bolivar M on 10/24/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit
import Alamofire
import DGActivityIndicatorView
import CoreData

class ApiRequests: NSObject {
    
    //MARK: - GET METHODS
    
    class func simpleGet(endpoint:String, completion: ((_ result : NSDictionary ) -> Void)?){ // basic get request using alamofire library and a custom Activity indicator view
        
        var activityIndicatorView = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.lineScalePulseOutRapid, tintColor: UIColor.white, size: 50)
        let aiView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        activityIndicatorView = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.lineScalePulseOutRapid, tintColor: UIColor.white, size: 50)
        activityIndicatorView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        activityIndicatorView?.startAnimating()
        aiView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        aiView.addSubview(activityIndicatorView!)
        UIApplication.shared.keyWindow?.addSubview(aiView)
        aiView.isHidden = false
        
        Alamofire.request(kApiEnvironment + endpoint).response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if let appsDictionary = convertStringToDictionary(text: utf8Text) {
                    completion! (appsDictionary as NSDictionary)
                }else{
                    completion! (["error":"Response Error"])
                }
            }
            
            aiView.isHidden = true
            activityIndicatorView?.removeFromSuperview()
        }
        
    }
    
    class func getAppList(completion: ((_ result : [App] ) -> Void)?) { // parsing app data and storing on CoreData
        
        if Reachability.isConnectedToNetwork() == true
        {
            print("Internet Connection Available!")
            
            ApiRequests.simpleGet(endpoint: kApiUrlAppList) { (response) in
                //cleaning database for preventing repeated data
                RappManager.clearAllData()
                
                let feed = (response as NSDictionary).object(forKey: "feed")
                let entry = (feed as! NSDictionary).object(forKey: "entry")
                
                for appData in entry as! NSArray{
                    //saving on CoreData, if there is not internet connection return last syncrhonized info and show a message
                    let _ = App(appData as! Dictionary<String, AnyObject>)
                }
                completion!([])
            }
        }
        else
        {
            print("Internet Connection not Available!")
            //showing internet failed connection
            completion!([])
            
        }

       
    }

    
    class func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    // MARK: CoreData methods
    
    class func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
   
    

    
}
