//
//  DetailRestaurant.swift
//  Spot
//
//  Created by Mario Sanchez on 25/11/16.
//  Copyright © 2016 Mario Sanchez. All rights reserved.
//

import Foundation
import UIKit
class Cdetail : UIViewController {
    
    var image = UIImage()
    var titulo = String()
    var info = String()
    var starfolwers = String()
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var mainProfileImage: UIImageView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblStartFollowers: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainProfileImage.layer.cornerRadius = mainProfileImage.frame.size.width / 2
        mainProfileImage.clipsToBounds = true
        mainProfileImage.layer.borderWidth = 3.0;
        mainProfileImage.layer.borderColor = UIColor.white.cgColor
        mainProfileImage.layer.cornerRadius = 10.0;
        
        mainImage.image = image
        mainProfileImage.image = image
        lblTitle.text = titulo as! String
        lblInfo.text = info as! String
        lblStartFollowers.text = starfolwers as! String
    }
    
}
