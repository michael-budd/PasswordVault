//
//  PasswordDetailViewController.swift
//  TheVault
//
//  Created by Michael Budd on 12/9/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import UIKit

class PasswordDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    // MARK: - Properties
    var password: Password?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabels()
        setUpUI()
        
    }
    
    func updateLabels() {
        guard let password = password else { return }
        
        websiteLabel.text = password.website
        usernameLabel.text = password.username
        passwordLabel.text = password.secret
        
    }
    
    func setUpUI() {
        self.view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        self.title = password?.website
    }

}
