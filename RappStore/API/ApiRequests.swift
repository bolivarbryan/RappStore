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

class ApiRequests: NSObject {
    
    //MARK: - GET METHODS
    
    class func simpleGet(url:String, completion: ((_ result : NSDictionary ) -> Void)?){ // basic get request using alamofire library and a custom Activity indicator view
        
        var activityIndicatorView = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.lineScalePulseOutRapid, tintColor: UIColor.white, size: 50)
        let aiView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        activityIndicatorView = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.lineScalePulseOutRapid, tintColor: UIColor.white, size: 50)
        activityIndicatorView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        activityIndicatorView?.startAnimating()
        aiView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        aiView.addSubview(activityIndicatorView!)
        UIApplication.shared.keyWindow?.addSubview(aiView)
        
        aiView.isHidden = false
        
        Alamofire.request("https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(convertStringToDictionary(text: utf8Text))
            }
            
            aiView.isHidden = true
            activityIndicatorView?.removeFromSuperview()
        }
        
    }
    
    
    class func getAppList(completion: ((_ result : [App] ) -> Void)?){
    
        ApiRequests.simpleGet(url: "") { (dic) in
            
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
}
