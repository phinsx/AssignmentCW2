//
//  UploadShop.swift
//  Assignment
//
//  Created by k ph on 12/1/2022.
//

import UIKit
import FirebaseStorage

class UploadShop: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var urlText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private let storage = Storage.storage().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
//              let url = URL(string: urlString) else { return }
//
//        urlText.text = urlString
//
//        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
//            guard let data = data, error == nil else { return }
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
//                self.imageView.image = image
//            }
//        })
//        task.resume()
    }
    
    @IBAction func uploadBtn(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let imageData = image.pngData() else{return}
        storage.child("images/file.png").putData(imageData, metadata: nil, completion: {_,error in
            guard error == nil else {
                print("Failed");
                return
            }
            self.storage.child("images/file.png").downloadURL(completion: {url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            })
            
        })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
