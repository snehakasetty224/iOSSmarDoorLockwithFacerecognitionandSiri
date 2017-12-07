//
//  HistoryViewController.swift
//  RasberyPiLock
//
//  Created by chalapati rao avadhanula venkata on 11/29/17.
//  Copyright © 2017 Sneha Kasetty Sudarshan. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var historytable: UITableView!
    let userlist = ["User1", "User2", "User3", "User4", "User1", "User2", "User3", "User4"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userlist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! customtableview
       cell.historyview.layer.cornerRadius = cell.historyview.frame.height/3
       cell.historyuser.text = userlist[indexPath.row]
       cell.historyimage.image = UIImage(named: userlist[indexPath.row])
       cell.historyimage.layer.cornerRadius = cell.historyview.frame.height/4
       return cell
    }
    override func viewDidLoad() {
        historytable.delegate = self
        historytable.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
