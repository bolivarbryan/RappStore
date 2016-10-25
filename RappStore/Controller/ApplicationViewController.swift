//
//  ApplicationViewController.swift
//  RappStore
//
//  Created by Bryan A Bolivar M on 10/24/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit
import SDWebImage
class ApplicationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var apps:[App]! = []
    var selectedApp:App! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DetailsSegue") {
            let viewController:ApplicationDetailsViewController = segue.destination as! ApplicationDetailsViewController
            viewController.title = self.selectedApp.name
            viewController.app = self.selectedApp
        }
    }
    
    
    // MARK: UICollection view Delegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedApp =  apps[indexPath.row]
        self.performSegue(withIdentifier: "DetailsSegue", sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCollectionViewCell",
                                                      for: indexPath) as! AppCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.name.text = apps[indexPath.row].name
        cell.artist.text = apps[indexPath.row].artist
        cell.price.text = apps[indexPath.row].price
        
        cell.picture.sd_setImage(with: NSURL(string: apps[indexPath.row].image)! as URL!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
