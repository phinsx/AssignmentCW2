//
//  ShopFile.swift
//  Assignment
//
//  Created by k ph on 13/1/2022.
//

import UIKit
import FirebaseFirestore

class ShopFile: UIViewController {
    
    @IBOutlet weak var shopData: UILabel!
    @IBOutlet weak var shopName: UITextField!
    @IBOutlet weak var shopInfo: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addShop(_ sender: Any) {
        if  shopName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            shopInfo.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            address.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNum.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {

            let alertController = UIAlertController(title: "Oops!", message: "Please fill in all fields.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        let shopName = shopName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let shopDetail = shopInfo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let shopAddress = address.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let shopPhone = phoneNum.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        
        db.collection("Shops").document(shopName).setData(["shopname": shopName, "description": shopDetail, "address": shopAddress, "phoneNum": shopPhone]) { error in
            
            if error != nil{
                let alertController = UIAlertController(title: "Oops!", message: "Error saving data.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func upData(_ sender: Any) {
        
    }
    
    @IBAction func refreshData(_ sender: Any) {
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
