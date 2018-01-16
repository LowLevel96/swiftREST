//
//  ViewController.swift
//  PostRequestTest
//
//  Created by Dusan Stojnic on 1/13/18.
//  Copyright © 2018 Dusan Stojnic. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func registerButtonAction(_ sender: UIButton) {
        
        let username: String! = usernameTextField.text
        let email: String! = emailTextField.text
        let password: String! = passwordTextField.text
        
        let parameters: Parameters = [
            "username": username,
            "email": email,
            "password": password
        ]
        
        Alamofire.request("http://127.0.0.1:7002/api/users/register", method: .post, parameters: parameters).responseJSON { response in
            debugPrint(response)
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

