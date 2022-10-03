//
//  LoginViewController.swift
//  Twitter
//
//  Created by SHAdON . on 10/1/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            print("User is logged in, so do not ask them to log in again")
            self.performSegue(withIdentifier: K.NavIdentifiers().loginToHome, sender: self)
        }
    }
    
    // allow the uset to stay logged in as long as they do not log out
    @IBAction func loginPressed(_ sender: Any) {
        TwitterAPICaller.client?.login(url: K.ApiTokens().authEndPoint, success: {
            
            // this is how we save user sessions
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            // print("Logged in successiully")
            self.performSegue(withIdentifier: K.NavIdentifiers().loginToHome, sender: self)
        }, failure: { error in
            print("Could not login, ", error)
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
