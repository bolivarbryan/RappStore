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
    
    let headerHeight = 200
    let parallaxHeight = 150
    let minimumParallaxHeight = 80
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let headerView:UIImageView = UIImageView()
        headerView.sd_setImage(with: NSURL(string: app.image) as! URL)
        headerView.contentMode = UIViewContentMode.scaleAspectFit;
        headerView.frame = CGRect(x: 0, y: 10, width: Int(self.scrollView.frame.size.width), height: headerHeight)
        headerView.backgroundColor = UIColor.black
        scrollView.parallaxHeader.view = headerView;
        scrollView.parallaxHeader.height = CGFloat(self.view.frame.size.width);
        scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill;
        scrollView.parallaxHeader.minimumHeight = CGFloat(minimumParallaxHeight);
        
        self.summary.text = app.summary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func openLinkInAppStore(_ sender: AnyObject) {
        print(app.link)
        UIApplication.shared.open(app.link as URL, options: [:], completionHandler: nil)
    }
}
