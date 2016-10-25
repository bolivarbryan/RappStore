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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCollectionViewCell",
                                                      for: indexPath) as! AppCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.name.text = apps[indexPath.row].name
        cell.artist.text = apps[indexPath.row].artist
        cell.price.text = apps[indexPath.row].price
        
        cell.picture.sd_setImage(with: NSURL(string: apps[indexPath.row].image)! as URL!)
        //cell.picture
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
