//
//  ViewController.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 27/08/2022.
//

import UIKit
import Alamofire



class LoginViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var loadGame: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setup()

//        let headers: HTTPHeaders = [.authorization(bearerToken: "token")]
//        var token = "Data()"
//
//        DefaultsHelper.shared.retrieveSavedItemCount()
//
//
//        AF.request("https://transformers-api.firebaseapp.com/allspark", method: .get)
//            .response { handle in
//                print(handle.data)
//                print(String(data: handle.data!, encoding: .utf8))
//                token = String(data: handle.data!, encoding: .utf8)!
//
//                DefaultsHelper.shared.saveValue(valueToSaveInDefaults: token, keyForSavedValue: "token")
//                DefaultsHelper.shared.retrieveSavedItemCount()
//
//            }
//
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            AF.request("https://transformers-api.firebaseapp.com/transformers", method: .get, headers: [.authorization(bearerToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1OQVBKSUFkQ282SExReEhTQXFYIiwiaWF0IjoxNjYxNTIwMTMwfQ.w3N87I9V2x2eXkljB1tUuy0DaLqnfMZOTrk0qPsoG3Y")])
//                .response { handle in
//                    print(handle.data)
//                    print(String(data: handle.data!, encoding: .utf8))
//                }
//        }
        



    }

    override func viewWillAppear(_ animated: Bool) {
        
        OrientationLocker.lockOrientation(.portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        OrientationLocker.lockOrientation(.allButUpsideDown)
        
    }
    
    
    @IBAction func startGame(_ sender: UIButton) {
        
        
        Networker().getNewToken(buttonToDisable: &startGame) { [weak self] token in
            
            self?.startGame.setTitle("Start A New Game", for: .normal)
            self?.startGame.isEnabled = true
            self?.loadGame.isEnabled = true
            
            print("\nGame Start\nToken =", token ?? "No token")
            
            DefaultsHelper.shared.saveValue(valueToSaveInDefaults: token, keyForSavedValue: "token")
            
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: VcNames.homepage.rawValue)
            self?.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
    }
    
    
    @IBAction func loadGame(_ sender: UIButton) {
        
        // use prev token from defaults
        let vc = storyboard?.instantiateViewController(withIdentifier: VcNames.homepage.rawValue)
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    /// Perform basic setup of the vc
    func setup() {
                
        startGame.layer.cornerRadius = 20
        loadGame.layer.cornerRadius = 20
        
        DefaultsHelper.shared.retrieveSavedItemCount()
//        UserDefaults.resetDefaults()
        DefaultsHelper.shared.retrieveSavedItemCount()
        
        if DefaultsHelper.shared.retrieveValue(keyForSavedValue: "token", savedValueType: .String) as? String ?? String() == String() {
            loadGame.isEnabled = false
        }
        
    }
    
}


extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
