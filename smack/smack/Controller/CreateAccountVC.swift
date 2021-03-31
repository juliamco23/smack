//
//  CreateAccountVC.swift
//  smack
//
//  Created by Juliam Costa on 26/03/2021.
//

import UIKit

class CreateAccountVC: UIViewController {

    //Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    print("You're in! Chat a lot and be Kind!", AuthService.instance.authToken)
                }
            }
        }
    }
    @IBAction func pickBGColorpressed(_ sender: Any) {
        
    }
    @IBAction func pickAvaterPressed(_ sender: Any) {
        
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
       performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
