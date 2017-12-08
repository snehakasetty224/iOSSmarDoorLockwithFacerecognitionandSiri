
//
//  HomeViewController.swift
//  RasberyPiLock
//
//  Created by chalapati rao avadhanula venkata on 11/29/17.
//  Copyright © 2017 Sneha Kasetty Sudarshan. All rights reserved.
//

import Foundation
import Intents
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var visitorimage: UIImageView!
    @IBOutlet weak var visitorname: UILabel!
   // @IBOutlet weak var addbutton: UIButton!
    
    var notknown = ["unknown", "not known", "not found"]

    func addContact(){
        if (visitorname.text == "unknown"){
            //addbutton.isEnabled = true
            //addbutton.isHidden = false
        }
        else {
            //addbutton.isEnabled = false
            //addbutton.isHidden = true
        }
    }
  /* sneha not required as we are going to add contacts through history page
    @IBAction func addContactButton(_ sender: Any) {
       
    }*/
    
    @IBAction func addToContact(_ sender: Any) {
         performSegue(withIdentifier: "addcontactsegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactscontroller = segue.destination as! ContactsViewController
        contactscontroller.newcontact = visitorname.text!
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContact()
        // Do any additional setup after loading the view, typically from a nib.
        INPreferences.requestSiriAuthorization { (status) in
            
        }
        
        let myVocab = ["push up", "sit up", "pull up", "open the door"]
        let myVocabSet = NSOrderedSet(array: myVocab) //Convert myVocab to an NSOrderedSet
        INVocabulary.shared().setVocabularyStrings(myVocabSet, of: .workoutActivityName)
        
        self.whoIsAtTheDoor()
        self.fetchPhoto()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func lockDoor(_ sender: Any) {
        lockTheDoor()
    }
    
    
    @IBAction func unlockDoor(_ sender: Any) {
        unlockTheDoor()
    }
    
    
    
    func whoIsAtTheDoor() {
        let req = NSMutableURLRequest(url: NSURL(string:"http://192.168.0.12:5000/clickPhoto")! as URL)
        let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: { data,response,error in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            if let responseJSON = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]{
                
                print(responseJSON)
                if let response_token:String = responseJSON["Name"] as? String {
                    print(response_token)
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.visitorname.text = response_token
                    })
                }
            }
        })
        task.resume()
    }
    
    /**
     * Fetch the photo
     **/
    func fetchPhoto() {
        let string_url = "http://192.168.0.12:5000/images/images0.jpg";
        /* let url = URL(string:string_url)
         let data = try? Data(contentsOf: url!)
         visitorimage.image = UIImage(data: data!)
         */
        URLSession.shared.dataTask(with: NSURL(string: string_url)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image1 = UIImage(data: data!)
                self.visitorimage.image = image1
            })
            
        }).resume()
    }
    
    /*
     * Lock the door
     */
    func lockTheDoor() {
        let req = NSMutableURLRequest(url: NSURL(string:"http://192.168.0.12:5000/lock")! as URL)
        req.httpMethod = "GET"
        req.httpBody = "key=\"value\"".data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
            if error != nil {
                // Error
                print(error?.localizedDescription ?? "default error ")
            } else {
                // Successfull
                print(String(data: data!, encoding: String.Encoding.utf8) ?? "default error ")
            }
            }.resume()
    }
    
    /*
     * UnLock the door
     */
    func unlockTheDoor() {
        let req = NSMutableURLRequest(url: NSURL(string:"http://192.168.0.12:5000/unlock")! as URL)
        req.httpMethod = "GET"
        req.httpBody = "key=\"value\"".data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
            if error != nil {
                // Error
                print(error?.localizedDescription ?? "default error ")
            } else {
                // Successfull
                print(String(data: data!, encoding: String.Encoding.utf8) ?? "default error ")
            }
            }.resume()
    }
}

