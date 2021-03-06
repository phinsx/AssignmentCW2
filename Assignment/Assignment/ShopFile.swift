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
    @IBOutlet weak var showDetail: UILabel!
    
    @IBOutlet weak var test: UILabel!
    var merchantEmail = ""
    var merchantShop = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        test.text = merchantShop
        db.collection("Shops").document(merchantShop).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else { return }
            guard let shopName = userdata["shopname"] as? String else{ return };
            guard let shopDetail = userdata["description"] as? String else { return }
            guard let shopaddress = userdata["address"] as? String else { return }
            guard let shopNum = userdata["phoneNum"] as? String else { return }
            self.showDetail.text = "Shop Name:  " + shopName + "  \n" + "Shop description :  " + shopDetail + "  \n" + "Shop Address :  " + shopaddress + "  \n" + "Contact :  " + shopNum
        }
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
        let newshopName = shopName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let shopDetail = shopInfo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let shopAddress = address.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let shopPhone = phoneNum.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        
        db.collection("Shops").document(newshopName).setData(["shopname": newshopName, "description": shopDetail, "address": shopAddress, "phoneNum": shopPhone]) { error in
            
            if error != nil{
                let alertController = UIAlertController(title: "Oops!", message: "Error saving data.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        db.collection("merchants").document(merchantEmail).updateData([
            "shopname": newshopName as Any
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        self.merchantShop = newshopName
    }
    
    @IBAction func upData(_ sender: Any) {
        
        
        db.collection("Shops").document(merchantShop).setData([
            "shopname": shopName.text as Any,
            "description": shopInfo.text as Any,
            "address": address.text as Any,
            "phoneNum": phoneNum.text as Any
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        db.collection("merchants").document(merchantEmail).updateData([
            "shopname": shopName.text as Any,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    @IBAction func refreshData(_ sender: Any) {
        db.collection("Shops").document(merchantShop).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else { return }
            guard let shopName = userdata["shopname"] as? String else{ return };
            guard let shopDetail = userdata["description"] as? String else { return }
            guard let shopaddress = userdata["address"] as? String else { return }
            guard let shopNum = userdata["phoneNum"] as? String else { return }
            self.showDetail.text = "Shop Name:  " + shopName + "  \n" + "Shop description :  " + shopDetail + "  \n" + "Shop Address :  " + shopaddress + "  \n" + "Contact :  " + shopNum
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let shopNameToPro = merchantShop
        if segue.identifier == "returnValToMerchant" {
            let shopText = segue.destination as! MerchantHome
            shopText.shopName = shopNameToPro
        }
    }
    

}
