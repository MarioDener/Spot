//
//  ArtistViewController.swift
//  Spot
//
//  Created by Mario Sanchez on 24/11/16.
//  Copyright © 2016 Mario Sanchez. All rights reserved.
//

import UIKit
import Alamofire

struct post {
    let mainImage: UIImage!
    let name: String!
}

class ArtistViewController: UITableViewController {
    
    var searchUrl = "https://api.spotify.com/v1/search?q=Foo&type=artist"
    var posts = [post]()
    typealias jsonStandard = [String:AnyObject]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        callAlamo(url: self.searchUrl)

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
        return self.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell")
        
        var lbl = cell?.contentView.viewWithTag(1) as! UILabel
        var img = cell?.contentView.viewWithTag(2) as! UIImageView
        
        // codigo para hacer redonda un imageview
        
        
        //lbl.text = self.posts[indexPath.row]
        img.image = posts[indexPath.row].mainImage
        
        lbl.text  = posts[indexPath.row].name
        return cell!
    }
    

    
    func callAlamo(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.parseData(jsonData: response.data!)
            
            
        })
    }
    
    func parseData(jsonData:Data){
        do {
            var readbleJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! jsonStandard
            
            if let artists = readbleJson["artists"] as? jsonStandard {
                if let items = artists["items"] as? [jsonStandard] {
                    for i in 0..<items.count {
                        let item = items[i]                       
                        
                        let name = item["name"] as! String
                        
                        if let images = item["images"] as? [jsonStandard] {
                            if images.count > 0 {
                                
                            let imageData = images[0]
                            
                            
                            let mainImageURL = URL(string: imageData["url"] as! String)
                            let mainImageDATA = NSData(contentsOf: mainImageURL!)
                            
                            let mainImage = UIImage(data: mainImageDATA as! Data)
                            posts.append(post.init(mainImage: mainImage, name: name))
                            self.tableView.reloadData()
                            }
                            else {
                                var img:UIImage = UIImage(named: "foo-fighters-candice-lawler")!
                                posts.append(post.init(mainImage: img, name: name))
                                self.tableView.reloadData()
                            }
                        }
                      
                        
                        
                    }
                
                }
            }
        } catch {
            print("error")
        }
    }

}
