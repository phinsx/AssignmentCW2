//
//  UserSignUp.swift
//  Assignment
//
//  Created by k ph on 9/1/2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class UserSignUp: UIViewController {
    
    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPw: UITextField!
    @IBOutlet weak var confirmPw: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func validateTextField() -> String? {
//    // Check all textFields are filled in
//        if userEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            userPw.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            confirmPw.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            userFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            userLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//
//            let alertController = UIAlertController(title: "Oops!", message: "Please fill in all fields.", preferredStyle: .alert)
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            present(alertController, animated: true, completion: nil)
//        }
//
//        let cleanedPassword = userPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        if Helper.isPasswordValid(cleanedPassword) == false{
//            let alertController = UIAlertController(title: "Oops!", message: "Please make sure your password is at least 6 charcters, contains a special character and a number.", preferredStyle: .alert)
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            present(alertController, animated: true, completion: nil)
//        }
//        if confirmPw.text != userPw.text {
//            let alertController = UIAlertController(title: "Oops!", message: "Password do not match, please enter password again.", preferredStyle: .alert)
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            present(alertController, animated: true, completion: nil)
//        }
//        return nil
//    }

    
        
    @IBAction func userSignUp(_ sender: Any) {
    //    let error = validateTextField()
        
        if userEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            userPw.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPw.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            userFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            userLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            let alertController = UIAlertController(title: "Oops!", message: "Please fill in all fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        
        let cleanedPassword = userPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Helper.isPasswordValid(cleanedPassword) == false{
            let alertController = UIAlertController(title: "Oops!", message: "Please make sure your password is at least 6 charcters, contains a special character and a number.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        if confirmPw.text != userPw.text {
            let alertController = UIAlertController(title: "Oops!", message: "Password do not match, please enter password again.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }else{
                
        //if error != nil{
            let firstName = userFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = userEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = userPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = userLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail:email, password: password) { (result, err) in
                if err != nil {
                    let alertController = UIAlertController(title: "Oops!", message: "Email has been registered.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(email).setData(["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]) { error in
                        
                        if error != nil{
                            let alertController = UIAlertController(title: "Oops!", message: "Error saving data.", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        }else{
                            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "UserLoginPage")
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
