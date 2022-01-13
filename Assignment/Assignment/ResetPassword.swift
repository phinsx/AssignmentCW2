//
//  ResetPassword.swift
//  Assignment
//
//  Created by k ph on 8/1/2022.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPassword: UIViewController {
    
    @IBOutlet weak var resetEmail: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func resetPw(_ sender: Any) {
        if self.resetEmail.text == "" {
                let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
            
            } else {
                Auth.auth().sendPasswordReset(withEmail: self.resetEmail.text!, completion: { (error) in
                    
                    var title = ""
                    var message = ""
                    
                    if error != nil {
                        title = "Error!"
                        message = (error?.localizedDescription)!
                    } else {
                        title = "Success!"
                        message = "Password reset email sent."
                        self.resetEmail.text = ""
                    }
                    
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                })
            }
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
