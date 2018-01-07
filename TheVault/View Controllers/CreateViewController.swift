//
//  CreateViewController.swift
//  TheVault
//
//  Created by Michael Budd on 12/9/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UI
    
    func setUpUI() {
        
        self.view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        self.saveButton.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        self.saveButton.setTitle("SAVE", for: .normal)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.setTitleColor(UIColor.white, for: .normal)
        self.saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.saveButton.layer.cornerRadius = 5
        self.passwordtextField.isSecureTextEntry = true
        self.websiteTextField.delegate = self
        self.usernameTextField.delegate = self
        self.passwordtextField.delegate = self
        
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if websiteTextField.text != nil && usernameTextField.text != nil && passwordtextField.text != nil {
            guard let website = websiteTextField.text,
                let username = usernameTextField.text,
                let secret = passwordtextField.text else { return }
            
            let newPassword = Password(website: website, username: username, secret: secret)
            
            PasswordController.shared.saveToCloud(password: newPassword)
            
            resetTextFields()
        }
    }
    
    func resetTextFields() {
        
        self.websiteTextField.text = ""
        self.passwordtextField.text = ""
        self.usernameTextField.text = ""
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
