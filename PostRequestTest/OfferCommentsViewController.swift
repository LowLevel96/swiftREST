//
//  OffersCommentsViewController.swift
//  PostRequestTest
//
//  Created by Dusan Stojnic on 1/15/18.
//  Copyright © 2018 Dusan Stojnic. All rights reserved.
//

import UIKit
import Alamofire

class OfferCommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var commentsTableView: UITableView!
    var offerId:Int?
    var commentTextText:String?
    var commentId = [Int]()
    var commentText = [String]()
    var commentAuthorName = [String]()
    var commentsCount:Int?
    
    
    func getCommentCount(offerId: Int!){
  
        Alamofire.request("http://127.0.0.1:7002/api/offers/\(offerId!)/comments/count").responseJSON{ response in
            
            print(response)
            if let commentsCountJSON = response.result.value {
                print(commentsCountJSON)
                let commentsCountObject:Dictionary = commentsCountJSON as! Dictionary<String, Any>
                let commentsCountInt:Int = commentsCountObject["comments_count"] as! Int
                self.getCommentList(offerId: self.offerId!, commentsCount:commentsCountInt)
                //                return offersCountJSON
            }
        }
        
    }
    
    func getCommentList(offerId: Int, commentsCount: Int?) {
        print("Inside function")
        print(offerId.description)
//        http://127.0.0.1:7002/api/offers/7/comments
        Alamofire.request("http://127.0.0.1:7002/api/offers/\(offerId)/comments").responseJSON{ response in
            print(response)
            if commentsCount != 0 {
                if let commentsJSON = response.result.value {
                    for i in 0...commentsCount!-1 {
                        let commentsArray:Array = commentsJSON as! Array<Any>
                        let commentsObject:Dictionary = commentsArray[i] as! Dictionary<String, Any>
                        let commentId: Int = commentsObject["id"] as! Int
                        let commentText: String = commentsObject["comment_text"] as! String
                        let commentAuthorName: String = commentsObject["comment_authorName"] as! String
                        
                        self.commentId.append(commentId)
                        self.commentText.append(commentText)
                        self.commentAuthorName.append(commentAuthorName)
                    
                    }
                    print(self.commentText)
    //                let offerTitle:String = offersObject["offer_title"] as! String
    //                let offerDescription:String = offersObject["offer_description"] as! String
    //                let offerId:Int = offersObject["id"] as! Int
    //                print(offerTitle)
    //                print(offerDescription)
    //                self.titleList.append(offerTitle)
    //                self.descriptionList.append(offerDescription)
    //                self.idList.append(offerId)
                    
    //                for i in 0...offersCount-1 {
    //                    let offersObject:Dictionary = offersArray[i] as! Dictionary<String, Any>
    //                    let offerTitle:String = offersObject["offer_title"] as! String
    //                    let offerDescription:String = offersObject["offer_description"] as! String
    //                    let offerId:Int = offersObject["id"] as! Int
    //                    print(offerTitle)
    //                    print(offerDescription)
    //                    self.titleList.append(offerTitle)
    //                    self.descriptionList.append(offerDescription)
    //                    self.idList.append(offerId)
    //
    //                }
                    
                    //print(self.titleList)
                   self.commentsTableView.reloadData()
                    
                }
            }
            
        }
            
            
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return(commentText.count)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! OfferCommentsViewCell
//        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CommentCell")
        
//        cell.commentAuthorNameTextLabel
        
        cell.commentTextLabelText?.text = self.commentText[indexPath.row]
        cell.commentAuthorNameTextLabel?.text = self.commentAuthorName[indexPath.row]
        
        return(cell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCommentCount(offerId: self.offerId!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionToDetail(_ sender: UISegmentedControl) {
        performSegue(withIdentifier: "offerCommentsUnwindIndentifier", sender: self)
    }
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! OfferCommentsViewCell
//
//
//        return(cell)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
