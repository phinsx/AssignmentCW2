//
//  UserHome.swift
//  Assignment
//
//  Created by k ph on 9/1/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserHome: UIViewController {

    @IBOutlet weak var loginUser: UILabel!
    
    var loginEmail = " "
    let userdb = Firestore.firestore().collection("users")
    
//    func checkVal(){
//        print(loginEmail)
//        print()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.isModalInPresentation = true
        userdb.document(loginEmail).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else {
                return
            }
            guard let text = userdata["firstname"] as? String else{
                return
            }
            self.loginUser.text = "Welcom "+text
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
    
    @IBAction func infoPage(_ sender: Any) {
        self.performSegue(withIdentifier: "segueInfo", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let email = loginEmail
        if segue.identifier == "segueInfo" {
            let showText = segue.destination as! PersonalFile
            showText.infoEmail = email
        }
    }

}
