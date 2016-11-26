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
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var mainProfileImage: UIImageView!
    @IBOutlet weak var lblInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.image = image
        mainProfileImage.image = image
        lblTitle.text = titulo as! String
        lblInfo.text = info as! String
        
    }
    
}
