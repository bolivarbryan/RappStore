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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let headerView:UIImageView = UIImageView()
        headerView.sd_setImage(with: NSURL(string: app.image) as! URL)
        headerView.contentMode = UIViewContentMode.scaleAspectFit;
        
        scrollView.parallaxHeader.view = headerView;
        scrollView.parallaxHeader.height = 150;
        scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill;
        scrollView.parallaxHeader.minimumHeight = 20;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
