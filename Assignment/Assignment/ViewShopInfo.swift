//
//  ViewShopInfo.swift
//  Assignment
//
//  Created by k ph on 13/1/2022.
//

import UIKit
import Firebase
import FirebaseStorage

class ViewShopInfo: UIViewController {

    @IBOutlet weak var shopInfo: UILabel!
    
    var viewShopName = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showShopInfo()
    }
    
    func showShopInfo(){
        db.collection("Shops").document(viewShopName).getDocument{ (snapshot, error) in
            guard let userdata = snapshot?.data(), error == nil else { return }
            guard let shopName = userdata["shopname"] as? String else{ return };
            guard let shopDetail = userdata["description"] as? String else { return }
            guard let shopaddress = userdata["address"] as? String else { return }
            guard let shopNum = userdata["phoneNum"] as? String else { return }
            self.shopInfo.text = "Shop Name:  " + shopName + "  \n" + "Shop description :  " + shopDetail + "  \n" + "Shop Address :  " + shopaddress + "  \n" + "Contact :  " + shopNum
        }
    }
    
    @IBAction func webApi(_ sender: Any) {
        if let url = URL(string: "https://thehoneycombers.com/hong-kong/sugarman-candy-blowing-louis-to/") {
            UIApplication.shared.open(url)
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

