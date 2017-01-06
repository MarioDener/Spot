//
//  HomeController.swift
//  Spot
//
//  Created by Mario Sanchez on 24/11/16.
//  Copyright © 2016 Mario Sanchez. All rights reserved.
//

import UIKit
import Alamofire
//
struct dataCustomers {
    let image : UIImage!
    let name : String!
    let info: String!
    let follwers: Int!
    let likes: Int!
}

typealias jsonStandard = [String:AnyObject]
class HomeController: UITableViewController {
    
    var app = App()
    var customers = [dataCustomers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        self.callAlamo(url: "customer_json")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.customers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell")
        let label = cell?.contentView.viewWithTag(1) as! UILabel
        let image = cell?.contentView.viewWithTag(2) as! UIImageView
        let imageProfile = cell?.contentView.viewWithTag(3) as! UIImageView
        let starandfollwrs = cell?.contentView.viewWithTag(4) as! UILabel
        
        // codigo para hacer redonda un imageview
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
        imageProfile.clipsToBounds = true
        
        // variables para manejar mucho mejor los textos de estrellas y seguidores
        let followers = customers[indexPath.row].follwers
        let likes = customers[indexPath.row].likes
        
        // Configure the cell...
        label.text = customers[indexPath.row].name
        image.image = customers[indexPath.row].image
        imageProfile.image = customers[indexPath.row].image
        starandfollwrs.text = "Starts \(likes!)    |    Followers \(followers!)"
        
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPagh = self.tableView.indexPathForSelectedRow?.row
        
        let vb = segue.destination as! Cdetail
        vb.image = self.customers[indexPagh!].image
        vb.title = self.customers[indexPagh!].name
        vb.titulo = self.customers[indexPagh!].name
        vb.info = self.customers[indexPagh!].info
        
        let followers = self.customers[indexPagh!].follwers
        let likes = self.customers[indexPagh!].likes
        vb.starfolwers = "Starts \(likes!)    |    Followers \(followers!)"
    }
 
    
    
    func callAlamo(url: String) {
        
        Alamofire.request(app.construcUrl(url: url)).responseJSON(completionHandler: {
            response in
            self.parseData(jsonData: response.data!)
        })
    }
    
    func parseData(jsonData:Data) {
        do {
            var readJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! jsonStandard
            
            if let pcustomers = readJson["customers"] as? [jsonStandard] {
            
                for i in 0..<pcustomers.count {
                    // get del nombre de cada restaurante
                    
                    var nameCustomer = pcustomers[i]["name"] as! String
                    var informacion = pcustomers[i]["info"] as! String
                    var followers = pcustomers[i]["followers"] as? Int
                    var likes = pcustomers[i]["likes"] as? Int
                    
                    // get de la imagen de cada restaurante
                    let mainImageURL = URL(string: pcustomers[i]["image"] as! String)
                    // configuracion para obtener imagen
                    let mainImageData = NSData(contentsOf: mainImageURL!)
                    let mainImage = UIImage(data: mainImageData as! Data)
                    // agegar a la estructura las imagenes y los nombres
                    customers.append(dataCustomers.init(image: mainImage, name: nameCustomer,info: informacion, follwers: followers,likes: likes))
                    self.tableView.reloadData()
                }
                
            }
            
        } catch let error {
            print(error)
        }
    }

}














