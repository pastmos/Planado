//
//  LoginViewController.swift
//  Planado
//
//  Created by Past on 26.09.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentDate = GetCurrentDate()
       }

}

