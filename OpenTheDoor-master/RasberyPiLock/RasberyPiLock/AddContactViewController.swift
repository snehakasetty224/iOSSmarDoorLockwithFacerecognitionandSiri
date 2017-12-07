//
//  AddContactViewController.swift
//  RasberyPiLock
//
//  Created by Sneha Kasetty Sudarshan on 12/7/17.
//  Copyright © 2017 Sneha Kasetty Sudarshan. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, URLSessionDelegate,URLSessionTaskDelegate, URLSessionDataDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageSave: UIImageView!
    
    @IBAction func saveButton(_ sender: Any) {
        
        var url = "http://54.186.191.119:5000/upload/";
        url.append(nameTextField.text!);
        url.append(".jpg");
        var r  = URLRequest(url: URL(string : url)!)
        r.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        r.httpBody = createBody(
            boundary: boundary,
            data: UIImageJPEGRepresentation(imageSave.image!, 0.7)!,
            mimeType: "image/jpg",
            filename: "file")
        
        URLSession.shared.dataTask(with: r as URLRequest) { data, response, error in
            if error != nil {
                // Error
                print(error?.localizedDescription ?? "default error ")
            } else {
                // Successfull
                print(String(data: data!, encoding: String.Encoding.utf8) ?? "default error ")
            }
            }.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBody(
        boundary: String,
        data: Data,
        mimeType: String,
        filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
    


}
