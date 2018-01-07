//
//  PasswordsTableViewController.swift
//  TheVault
//
//  Created by Michael Budd on 12/9/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import UIKit

class PasswordsTableViewController: UITableViewController {
    
    var selectedPassword: Int = 0
    var totalPasswords: [Password]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PasswordController.shared.queryDatabase { (passwords) in
            self.totalPasswords = passwords
        }
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        self.title = "Passwords"
        navigationController?.navigationBar.barTintColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        
        PasswordController.shared.queryDatabase { (passwords) in
            self.totalPasswords = passwords
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let passwords = totalPasswords ?? []
        return passwords.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "passwordCell", for: indexPath)
        let currentPassword = totalPasswords?[indexPath.row]
        
        cell.textLabel?.text = currentPassword?.website
        cell.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let serialQueue = DispatchQueue(label: "selectedPW")
        
        serialQueue.async {
            self.selectedPassword = indexPath.row
            print("setting selected password")
        }
        
        serialQueue.sync {
            print("waiting for password to be selected")
            performSegue(withIdentifier: "toPasswordDetail", sender: self)
        }
        
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPasswordDetail" {
            let destinationVC = segue.destination as? PasswordDetailViewController
            destinationVC?.password = totalPasswords?[selectedPassword]
        }
    }

}
