//
//  MerchantPersonalFile.swift
//  Assignment
//
//  Created by k ph on 11/1/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class MerchantPersonalFile: UIViewController {
    
    @IBOutlet weak var merchantData: UILabel!
    @IBOutlet weak var merchantFirstName: UITextField!
    @IBOutlet weak var merchantLastName: UITextField!
    @IBOutlet weak var merchantEmail: UITextField!
    
    var infoEmail = " "
    let merchantdb = Firestore.firestore().collection("merchants")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.isModalInPresentation = true
        merchantdb.document(infoEmail).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else { return }
            guard let firstName = userdata["firstname"] as? String else{ return };
            guard let lastName = userdata["lastname"] as? String else { return }
            self.merchantData.text = "First Name:  " + firstName + "  \n" + "Last Name:  " + lastName
        }
    }
    
    @IBAction func updateData(_ sender: Any) {
        merchantdb.document(infoEmail).updateData([
            "firstname": merchantFirstName.text as Any,
            "lastname": merchantLastName.text as Any,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    @IBAction func refreshData(_ sender: Any) {
        merchantdb.document(infoEmail).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else { return }
            guard let firstName = userdata["firstname"] as? String else{ return };
            guard let lastName = userdata["lastname"] as? String else { return }
            self.merchantData.text = "First Name:  " + firstName + "  \n" + "Last Name:  " + lastName
        }
    }
    
    @IBAction func resetPw(_ sender: Any) {
        if self.merchantEmail.text == "" {
        let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    
    }else {
        Auth.auth().sendPasswordReset(withEmail: self.merchantEmail.text!, completion: { (error) in
            
            var title = ""
            var message = ""
            
            if error != nil {
                title = "Error!"
                message = (error?.localizedDescription)!
            } else {
                title = "Success!"
                message = "Password reset email sent."
                self.merchantEmail.text = ""
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
        }
    }
    
    @IBAction func deleteAcc(_ sender: Any) {
        merchantdb.document(infoEmail).delete() { err in
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
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserLoginPage")
                present(vc!, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
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
