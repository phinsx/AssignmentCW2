//
//  ShopChoice.swift
//  Assignment
//
//  Created by k ph on 13/1/2022.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class ShopChoice: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sugarBlownToy(_ sender: Any) {
        self.performSegue(withIdentifier: "toSugarBlownToy", sender: self)
    }
    
    @IBAction func sugarProduct(_ sender: Any) {
        self.performSegue(withIdentifier: "segueProduct", sender: self)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let shopName = "underwear"
        if segue.identifier == "toSugarBlownToy" {
            let shopText = segue.destination as! ViewShopInfo
            shopText.viewShopName = shopName
        }
        
        let productName = "underwear"
        if segue.identifier == "segueProduct" {
            let itemText = segue.destination as! ViewShopProduct
            itemText.checkProduct = productName
        }
    }
    
}
