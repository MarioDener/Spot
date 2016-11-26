//
//  App.swift
//  Spot
//
//  Created by Mario Sanchez on 24/11/16.
//  Copyright © 2016 Mario Sanchez. All rights reserved.
//

import UIKit
class App {
    let baseUrl = "http://localhost:3000/"
    
    
    func construcUrl(url:String) -> String {
        let newUrl = "\(self.baseUrl)\(url)"
        return newUrl
    }
    
}
