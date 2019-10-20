//
//  AccountPage.swift
//  BoxAssessment
//
//  Created by Sarah Mowris on 10/19/19.
//  Copyright © 2019 sarahmowris. All rights reserved.
//

import Foundation
import UIKit
import BoxSDK

class AccountPage: UIViewController {
    
    //Outlets
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var signout_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signout_button.layer.zPosition = 1
    }
    
    //Make Status Bar White
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Segment Segue
    @IBAction func segmentedButton(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 2 {
            performSegue(withIdentifier: "loanSegue", sender: self)
        }
    }
    
    //Sign Out Button (Revokes Authentication)
    @IBAction func signout(_ sender: UIButton) {
        KeychainTokenStore().clear { result in
            switch result  {
            case .success:
                self.performSegue(withIdentifier: "signoutSegue1", sender: self)
            case .failure:
                print("error")
            }
        }
    }
}
