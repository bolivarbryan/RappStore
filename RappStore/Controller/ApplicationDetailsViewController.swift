//
//  ApplicationDetailsViewController.swift
//  RappStore
//
//  Created by Bryan A Bolivar M on 10/25/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit
import SDWebImage
import MXParallaxHeader

class ApplicationDetailsViewController: UIViewController {
    var app:App! = nil
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var summary: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let headerView:UIImageView = UIImageView()
        headerView.sd_setImage(with: NSURL(string: app.image) as! URL)
        headerView.contentMode = UIViewContentMode.scaleAspectFit;
        headerView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: 200)
        headerView.backgroundColor = UIColor.black
        scrollView.parallaxHeader.view = headerView;
        scrollView.parallaxHeader.height = 150;
        scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill;
        scrollView.parallaxHeader.minimumHeight = 20;
        
        self.summary.text = app.summary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func openLinkInAppStore(_ sender: AnyObject) {
        UIApplication.shared.openURL(app.link as? URL)

    }
    

 
}
