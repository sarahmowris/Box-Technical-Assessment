//
//  LoanApplication.swift
//  BoxAssessment
//
//  Created by Sarah Mowris on 10/17/19.
//  Copyright © 2019 sarahmowris. All rights reserved.
//

import Foundation
import UIKit
import BoxSDK
import MobileCoreServices

var clients : BoxClient!


class LoanApplication : UIViewController {
    
    //Outlets
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var choose_button: UIButton!
    @IBOutlet weak var upload_button: UIButton!
    @IBOutlet weak var file_status: UILabel!
    @IBOutlet weak var signout_button: UIButton!
    
    //Document URL
    var fileURL: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signout_button.layer.zPosition = 1
        segments.selectedSegmentIndex = 2
        segments.isHighlighted = true
    }
    
    //Make Status Bar White
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Segment Segue
    @IBAction func segmentedButton(_ sender: UISegmentedControl) {
        if segments.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: "accountsSegue", sender: self)
        }
    }
    
    //Choose File Button
    @IBAction func choose_file(_ sender: UIButton) {
        DocumentPicker()
    }
    
    //Sign Out Button (Revokes Authentication)
    @IBAction func signout(_ sender: UIButton) {
        KeychainTokenStore().clear { result in
            switch result  {
            case .success:
                self.performSegue(withIdentifier: "signoutSegue", sender: self)
            case .failure:
                print("error")
            }
        }
    }
    
    
    //Upload File to Box
    @IBAction func upload_file(_ sender: UIButton) {
        let url_data = Data(fileURL.utf8)
        if fileURL == "" {
            DispatchQueue.main.async {
                self.file_status.text = "Upload Unsuccessful"
            }
        }
        clients.files.uploadFile(data: url_data, name: "Loan Application", parentId: "90453084064") { result in
            switch result  {
            case .success:
                DispatchQueue.main.async {
                    self.file_status.text = "Upload Successful!"
                    print("Success")
                }
            case .failure:
                DispatchQueue.main.async {
                    self.file_status.text = "Upload Unsuccessful"
                    print("error")
                }
            }
        }
    }
}

//Upload Document to App
extension LoanApplication: UIDocumentPickerDelegate {
    
    //UIDocument Protocols
    func documentMenu(_ documentMenu: UIDocumentPickerDelegate, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
    }
    
    
    func DocumentPicker() {
        let menu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        menu.delegate = self
        menu.modalPresentationStyle = .formSheet
        present(menu, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        fileURL = urls[0].absoluteString
        //print(fileURL)
    }
}
