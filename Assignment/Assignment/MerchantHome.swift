//
//  MerchantHome.swift
//  Assignment
//
//  Created by k ph on 11/1/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class MerchantHome: UIViewController {
    
    @IBOutlet weak var merchantName: UILabel!
    
    var loginEmail = " "
    let merchantdb = Firestore.firestore().collection("merchants")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.isModalInPresentation = true
        merchantdb.document(loginEmail).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else {
                return
            }
            guard let text = userdata["firstname"] as? String else{
                return
            }
            self.merchantName.text = "Welcom "+text
        }
    }
    
    @IBAction func SignOutbtn(_ sender: Any) {
        let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MerchantLoginPage")
                present(vc!, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
    }
    
    @IBAction func merchantInfo(_ sender: Any) {
        self.performSegue(withIdentifier: "MerchantProfile", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let email = loginEmail
        if segue.identifier == "MerchantProfile" {
            let showText = segue.destination as! MerchantPersonalFile
            showText.infoEmail = email
        }
    }
    

}
