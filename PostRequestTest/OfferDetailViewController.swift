//
//  OfferDetailViewController.swift
//  PostRequestTest
//
//  Created by Dusan Stojnic on 1/15/18.
//  Copyright © 2018 Dusan Stojnic. All rights reserved.
//

import UIKit
import Alamofire

class OfferDetailViewController: UIViewController {
    @IBOutlet weak var offerIdLabelText: UILabel!

    @IBOutlet weak var offerTitleLabelText: UILabel!
    @IBOutlet weak var offerDescriptionTextView: UITextView!
    @IBOutlet weak var offerTripStartsLabelText: UILabel!
    
    @IBOutlet weak var offerTripEndsLabelText: UILabel!
    var offerId:Int?
    @IBOutlet weak var offerExpiresLabelText: UILabel!
   
    @IBOutlet weak var offerPricesLabelText: UILabel!
    
    
    
    @IBAction func offerCommentsLoad(_ sender: UISegmentedControl) {
        performSegue(withIdentifier: "offerCommentsSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OfferCommentsViewController {
            destination.offerId = self.offerId
        }
    }
    
    @IBOutlet weak var segmentedControlComments: UISegmentedControl!
    
    @IBAction func offerCommentsUnwind(_ segue: UIStoryboardSegue){
        self.segmentedControlComments.selectedSegmentIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Detail View")
        if let offerIdToPass = offerId {
            self.offerIdLabelText.text = offerIdToPass.description
            getOfferDetail(offerId: offerIdToPass)
        }
        
//        if let idToDisplay = offerId {
//            offerIdLabel.text = idToDisplay as! String
//        }
//
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getOfferDetail(offerId: Int) {
        print("Inside function")
        print(offerId.description)
        Alamofire.request("http://127.0.0.1:7002/api/offers/\(offerId)/detail/").responseJSON{ response in
            print(response)
            
            if let offerDetailJSON = response.result.value {

                let offerDetailObject:Dictionary = offerDetailJSON as! Dictionary<String, Any>
                
                // Get fields values
                let offerTitle:String = offerDetailObject["offer_title"] as! String
                let offerDescription:String = offerDetailObject["offer_description"] as! String
                let offerTripStarts:String = offerDetailObject["offer_tripStart"] as! String
                let offerTripEnds:String = offerDetailObject["offer_tripEnd"] as! String
                let offerExpires:String = offerDetailObject["offer_expires"] as! String
                let offerTripPrice:Int = offerDetailObject["offer_prices"] as! Int
                
                
                // Set detail labels with values from api
                self.offerTitleLabelText.text = offerTitle
                self.offerDescriptionTextView.text = offerDescription
                self.offerTripStartsLabelText.text = offerTripStarts
                self.offerTripEndsLabelText.text = offerTripEnds
                self.offerExpiresLabelText.text = offerExpires
                self.offerPricesLabelText.text = offerTripPrice.description
            }


        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
