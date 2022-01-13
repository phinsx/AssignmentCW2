//
//  PersonalFile.swift
//  Assignment
//
//  Created by k ph on 10/1/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PersonalFile: UIViewController {

    @IBOutlet weak var userInfo: UILabel!
    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    
    var infoEmail = ""
    let userdb = Firestore.firestore().collection("users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.isModalInPresentation = true
        userdb.document(infoEmail).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else { return }
            guard let firstName = userdata["firstname"] as? String else{ return };
            guard let lastName = userdata["lastname"] as? String else { return }
            self.userInfo.text = "First Name:  " + firstName + "  \n" + "Last Name:  " + lastName
        }
    }

    @IBAction func updateBtn(_ sender: Any) {
        userdb.document(infoEmail).updateData([
            "firstname": userFirstName.text as Any,
            "lastname": userLastName.text as Any,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    @IBAction func reloadData(_ sender: Any) {
        userdb.document(infoEmail).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else { return }
            guard let firstName = userdata["firstname"] as? String else{ return };
            guard let lastName = userdata["lastname"] as? String else { return }
            self.userInfo.text = "First Name:  " + firstName + "  \n" + "Last Name:  " + lastName
        }
    }
    
    @IBAction func resetPw(_ sender: Any) {
        if self.userEmail.text == "" {
        let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    
    }else {
        Auth.auth().sendPasswordReset(withEmail: self.userEmail.text!, completion: { (error) in
            
            var title = ""
            var message = ""
            
            if error != nil {
                title = "Error!"
                message = (error?.localizedDescription)!
            } else {
                title = "Success!"
                message = "Password reset email sent."
                self.userEmail.text = ""
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
        }
    }
    
    @IBAction func deleteAcc(_ sender: Any) {
        userdb.document(infoEmail).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        if Auth.auth().currentUser != nil {
          // User is signed in.
            let user = Auth.auth().currentUser
            user?.delete { error in
                if error != nil {
                    //
            } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
            }
        }
        }
    }
    
    @IBAction func backUserHome(_ sender: Any) {
        self.performSegue(withIdentifier: "userInfoToUserHome", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let email = infoEmail
        if segue.identifier == "userInfoToUserHome" {
            let showText = segue.destination as! UserHome
            showText.loginEmail = email
        }
    }
    
}
