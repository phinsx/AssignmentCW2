//
//  MerchantSigUp.swift
//  Assignment
//
//  Created by k ph on 11/1/2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class MerchantSigUp: UIViewController {

    @IBOutlet weak var merchantFirstName: UITextField!
    @IBOutlet weak var merchantLastName: UITextField!
    @IBOutlet weak var merchantEmail: UITextField!
    @IBOutlet weak var merchantPw: UITextField!
    @IBOutlet weak var merchantConfirmPw: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func merchantCreateAcc(_ sender: Any) {
        if merchantEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            merchantPw.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            merchantConfirmPw.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            merchantFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            merchantLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            let alertController = UIAlertController(title: "Oops!", message: "Please fill in all fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        
        let cleanedPassword = merchantPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Helper.isPasswordValid(cleanedPassword) == false{
            let alertController = UIAlertController(title: "Oops!", message: "Please make sure your password is at least 6 charcters, contains a special character and a number.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        if merchantConfirmPw.text != merchantPw.text {
            let alertController = UIAlertController(title: "Oops!", message: "Password do not match, please enter password again.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }else{
                
        //if error != nil{
            let firstName = merchantFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = merchantEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = merchantPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = merchantLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail:email, password: password) { (result, err) in
                if err != nil {
                    let alertController = UIAlertController(title: "Oops!", message: "Email has been registered.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let db = Firestore.firestore()
                    
                    db.collection("merchants").document(email).setData(["firstname": firstName, "lastname": lastName, "shopname": "No Shop Name yet", "uid": result!.user.uid]) { error in
                        
                        if error != nil{
                            let alertController = UIAlertController(title: "Oops!", message: "Error saving data.", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }else{
                            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "MerchantLoginPage")
                            self.present(vc1!, animated: true, completion: nil)
                        }
                    }
                }
            }
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
