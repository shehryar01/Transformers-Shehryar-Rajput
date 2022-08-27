//
//  Networker.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit
import Alamofire

class Networker {
    
    /// Returns a token retrieved fromthe spark api if successful
    /// - Parameters:
    ///   - buttonToDisable: Disables the login button, to prevent multiple requests to server
    ///   - completion: Returns optional token
    func getNewToken(buttonToDisable: inout UIButton, completion: @escaping (String?)->()) {
        
        buttonToDisable.setTitle("Starting Game...", for: .disabled)
        buttonToDisable.isEnabled = false
        
        AF.request("https://transformers-api.firebaseapp.com/allspark", method: .get)
            {$0.timeoutInterval = 5}
            .response { response in
                
                guard let safeData = response.data else {
                    completion(nil)
                    return
                }
                
                let token = String(data: safeData, encoding: .utf8)
                
                completion(token)
            }
    }
    
    
    
}
