//
//  UserLogin.swift
//  Assignment
//
//  Created by k ph on 9/1/2022.
//

import UIKit
import Firebase
import FirebaseAuth

class UserLogin: UITableViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPw: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .fullScreen
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    @IBAction func resetPw(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPassword")
            self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func userLogin(_ sender: Any) {
        let email = userEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = userPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password){ (result, err) in
            if err != nil{
                let alertController = UIAlertController(title: "Oops!", message: "Please an Email and password is current.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "UserHomeSegue", sender: self)
            }
        }
    }
    
    @IBAction func backHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
            self.present(vc!, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let email = userEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if segue.identifier == "UserHomeSegue" {
            let showText = segue.destination as! UserHome
            showText.loginEmail = email
        }
    }

}
