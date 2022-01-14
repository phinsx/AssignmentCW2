//
//  UpdateProduct.swift
//  Assignment
//
//  Created by k ph on 13/1/2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class UpdateProduct: UIViewController {

    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productDetial: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productQty: UITextField!
    
    var merchantShop = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addProduct(_ sender: Any) {
        if  productName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                productDetial.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                productPrice.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                productQty.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            let alertController = UIAlertController(title: "Oops!", message: "Please fill in all fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        let proName = productName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let proDetail = productDetial.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let proPrice = productPrice.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let proQty = productQty.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        
        db.collection("Products").document(merchantShop).setData(["productname": proName, "productdescription": proDetail, "price": proPrice, "qty": proQty]) { error in
            
            if error != nil{
                let alertController = UIAlertController(title: "Oops!", message: "Error saving data.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
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
