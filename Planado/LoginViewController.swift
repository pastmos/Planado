//
//  LoginViewController.swift
//  Planado
//
//  Created by Past on 26.09.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class LoginViewController: UIViewController {

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {

        Auth.auth().signIn(withEmail: self.loginText.text!, password: self.passwordText.text!) { (user, error) in
            
            if error != nil {
                
                var errorMessage = ""
                guard let errorCode = AuthErrorCode(rawValue: error!._code) else {
                    print("there was an error logging in but it could not be matched with a firebase code")
                    return
                }
                
                //let rrorCode = AuthErrorCode(rawValue: error!._code)
                
                switch errorCode {
                case  .invalidEmail:
                    errorMessage = "Неправильно введен E-mail"
                case  .userNotFound :
                    errorMessage = "Пользователь не существует"
                case  .wrongPassword:
                    errorMessage = "Неверный пароль"
                default:
                    errorMessage = "Неизвестная ошибка"
                }
                let alert = UIAlertController(title: "Ошибка!", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            self.performSegue(withIdentifier: "LoginToOrderListSeague", sender: nil)
            
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginToOrderListSeague" {
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        currentDate = GetCurrentDate()
        orders = []
        FetchParseOrdersListFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       }

}

