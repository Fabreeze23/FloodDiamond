//
//  LoginVC.swift
//  FloodDiamond
//
//  Created by Fabrice Mulumba on 7/7/18.
//  Copyright © 2018 Fabrice Mulumba. All rights reserved.
//
// Handles logging in to the app
//https://medium.com/@sdrzn/networking-and-persistence-with-json-in-swift-4-part-2-e4f35a606141
//https://www.raywenderlich.com/179924/secure-ios-user-data-keychain-biometrics-face-id-touch-id

import UIKit

struct KeychainConfiguration {
    static let serviceName = "FloodDiamond"
    static let accessGroup: String? = nil
}

class LoginVC: UIViewController {

    var login: Login!
    var userToSend: User!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var passwordItems: [KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
 // Function is for dismissing keyboard by tapping out of it
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        print(userNameTextField.text as Any)
        //login.username = userNameTextField.text!
        //login.password = passwordTextField.text!

        var usernameInput = ""
        var passwordInput = ""
        
        usernameInput = userNameTextField.text!
        passwordInput = passwordTextField.text!
        
        
        
        //login.username = usernameInput
        //login.password = passwordInput
        
        let login = Login(username: usernameInput, password: passwordInput)
        let loginURL = URL(string: POST_LOGIN_URL)
        
        var request = URLRequest(url: loginURL!)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        do {
            let loginData = try encoder.encode(login)
            // ... and set our request's HTTP body
            request.httpBody = loginData
            print("loginData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            print("Error")
        }
        
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                return
            }
            //Test for login
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) as? NSDictionary {
                
                
                //printing the json in console
                //print(jsonObj!.value(forKey: "userId")!)
                let userID = jsonObj!.value(forKey: "userId")! as! String
                let loggedInUser = User(userId: userID, username: usernameInput, password: passwordInput)
                print(loggedInUser)
                
                print("You are logged in!")
                
                
                self.userToSend = loggedInUser
                self.performSegue(withIdentifier: "loginToApp", sender: (Any).self)
                
                /*
                func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    if segue.identifier == "loginToApp" {
                        print("Check")
                        if let nav = segue.destination as? UITabBarController {
                            print("Check 2")
                            if let shopVC = nav.viewControllers![1] as? ShopVC {
                                print("Check 3")
                                shopVC.user = loggedInUser
                            }
                        }
                    }
                }
                */
            }
            
            else {
                self.showLoginFailedAlert()
            }
            
        }
        task.resume()
        
    }
    
    private func showLoginFailedAlert() {
        let alertView = UIAlertController(title: "Login Failed",
                                          message: "Wrong username or password.",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "Please try again", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToApp" {
            print("Check")
            if let nav = segue.destination as? UITabBarController {
                print("Check 2")
                if let shopVC = nav.viewControllers![1] as? ShopVC {
                    print("Check 3")
                    shopVC.user = userToSend
                }
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
