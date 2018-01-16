//
//  offersTableViewController.swift
//  PostRequestTest
//
//  Created by Dusan Stojnic on 1/13/18.
//  Copyright © 2018 Dusan Stojnic. All rights reserved.
//

import UIKit
import Alamofire



class OffersTableViewController: UITableViewController {

    let offer_title = ""
    let offer_description = ""
    var idToPass:Int?

    var titleList = [String]()
    var descriptionList = [String]()
    var idList = [Int]()
    
    @IBOutlet var offersTableVIew: UITableView!
    func getOffersCount(){

        Alamofire.request("http://127.0.0.1:7002/api/offers/count").responseJSON{ response in
          
            
            if let offersCountJSON = response.result.value {
                print(offersCountJSON)
                let offersCountObject:Dictionary = offersCountJSON as! Dictionary<String, Any>
                let offerCountInt:Int = offersCountObject["offer_count"] as! Int
                self.getOffersList(offersCount: offerCountInt)
//                return offersCountJSON
            }
        }

    }
    
    func getOffersList(offersCount: Int) {
        Alamofire.request("http://127.0.0.1:7002/api/offers/?format=json").responseJSON{ response in
            
            
            if let offersJSON = response.result.value {
                print(offersJSON)
                print(type(of: offersJSON))
                let offersArray:Array = offersJSON as! Array<Any>
                print(type(of: offersArray))
                for i in 0...offersCount-1 {
                    let offersObject:Dictionary = offersArray[i] as! Dictionary<String, Any>
                    let offerTitle:String = offersObject["offer_title"] as! String
                    let offerDescription:String = offersObject["offer_description"] as! String
                    let offerId:Int = offersObject["id"] as! Int
                    print(offerTitle)
                    print(offerDescription)
                    self.titleList.append(offerTitle)
                    self.descriptionList.append(offerDescription)
                    self.idList.append(offerId)
                    
                }
                
                print(self.titleList)
                self.offersTableVIew.reloadData()

                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOffersCount()
        self.tableView.delegate = self
        
        
        
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
        return(titleList.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell") as! OfferTableViewCell

        // Configure the cell...
        cell.offerTitleLabel?.text = self.titleList[indexPath.row]
        cell.offerDescriptionLabel?.text = self.descriptionList[indexPath.row]
        cell.offer_id = self.idList[indexPath.row]

        return(cell)
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath) as! OfferTableViewCell
        print(cell.offerTitleLabel.text as! String)
        print(cell.offer_id as! Int)
        self.idToPass = cell.offer_id
        performSegue(withIdentifier: "offerDetailSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OfferDetailViewController {
            destination.offerId = self.idToPass
        }
    }
    
    

}
