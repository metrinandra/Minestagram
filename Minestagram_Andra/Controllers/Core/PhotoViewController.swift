//
//  PostViewController.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//

import UIKit
import FirebaseStorage

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private let storage = Storage.storage().reference()
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        label.numberOfLines = 0
        label.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String, let url = URL(string: urlString) else {
            return
        }
        label.text = urlString
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data,_,error in            guard let data = data, error == nil else {
                return
            }
        //upd as soon as app gets response
        DispatchQueue.main.async {
            let image = UIImage(data: data)
            self.imageView.image = image
        }
    })
        task.resume()
}
    
    @IBAction func uploadPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated:true)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else{
            return
        }
        storage.child("images/file.png").putData(imageData, metadata: nil, completion: {_, error in guard error == nil else {
            print("Error with uploading")
            return
        }
        self.storage.child("images/file.png").downloadURL(completion: {url, error in
            guard let url = url, error == nil else{
                return
            }
        let urlString = url.absoluteString
            DispatchQueue.main.async {
                self.label.text = urlString
                self.imageView.image = image
            }
       
            
        print("Dowload URL: \(urlString)")
        UserDefaults.standard.set(urlString, forKey: "url")
        })
    })
    
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}
}
