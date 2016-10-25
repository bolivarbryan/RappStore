//
//  AppCollectionViewCell.swift
//  RappStore
//
//  Created by Bryan A Bolivar M on 10/24/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var nameConstraintLeft: NSLayoutConstraint!
    @IBOutlet weak var nameConstraintTop: NSLayoutConstraint!
}
