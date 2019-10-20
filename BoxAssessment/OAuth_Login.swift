//
//  ViewController.swift
//  BoxAssessment
//
//  Created by Sarah Mowris on 10/17/19.
//  Copyright © 2019 sarahmowris. All rights reserved.
//

import UIKit
import BoxSDK


class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login_button: UIButton!
    
    //SDK
    var SDK : BoxSDK!
    
    //Client Object
    var client : BoxClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //var developerToken : String = "Y0NMgz2eFKHJ0ZL6xPc35V5m6MvUf3DX"
        //login_button.layer.cornerRadius = 7
        //segment.selectedSegmentIndex = 0
        setup()
    }
    
    //Make Status Bar White
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    //Login Button
    @IBAction func login(_ sender: Any) {
        Oauth()
    }
    
    //Set Up SDK
    func setup() {
        SDK = BoxSDK(
            clientId: Client.clientID,
            clientSecret: Client.clientSecret
        )
    }
    
    //Authentication
    func Oauth() {
        SDK.getOAuth2Client(tokenStore: KeychainTokenStore()) { [weak self] result in
            switch result {
            case let .success(client):
                self?.client = client
                DispatchQueue.main.async {
                    self?.client = client
                    clients = self?.client
                    self!.performSegue(withIdentifier: "signinSegue", sender: self)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
//    //JWT
//    func authorizeJWT() {
//
//        SDK.getDelegatedAuthClient(authClosure: getToken(), uniqueID: "264977351") {
//            result in
//            switch result  {
//            case let .success(client):
//                self.client = client
//                clients = client
//                self.performSegue(withIdentifier: "signinSegue", sender: self)
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//    }
//
//    func getToken() -> DelegatedAuthClosure {
//        return { ID, completion in
//
//            //create url
//            let url = URL(string: "https://app.box.com/api/oauth2/token")
//
//            //URL request
//            var request = URLRequest(url: url!)
//            request.httpMethod = "POST"
//
//            //create session
//            let session = URLSession(configuration: .default)
//
//            //dataTask
//            session.dataTask(with: request) { (data, response, error) in
//                if let d = data, let token = String(data: d, encoding: .utf8) {
//                    print("Fetched Token: \(token)")
//                    completion(.success((accessToken: token, expiresIn: 999)))
//                }
//            }
//        }
//    }
//
    //Read JSON
//    if let path = Bundle.main.path(forResource: "config", ofType: "json") {
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//            if let result = json as? Dictionary<String, AnyObject> {
//
//            }
//        } catch {
//
//        }
//    }
    
}

//Client Class
struct Client {
    //static var client : BoxClient!
    static let clientID: String = "sq8kgr64iy3djthuvmzl010r3p9y6jdf"
    static let clientSecret: String = "lrONfG3DqIbJuDB1CNwTYcZvOwnsDNMu"
}

