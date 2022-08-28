//
//  Networker.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    
    // MARK: - Creating transformer
    
    func createJSONtoMakeTransformer(name: String,
                                     team: String,
                                     strength: String,
                                     intelligence: String,
                                     speed: String,
                                     endurance: String,
                                     rank: String,
                                     courage: String,
                                     firepower: String,
                                     skill: String) -> [String: AnyHashable]
    {
        let body : [String: AnyHashable] = [
            
            "id" : 0,
            "name": name,
            "team": team,
            "strength": Int(strength),
            "intelligence": Int(intelligence),
            "speed": Int(speed),
            "endurance": Int(endurance),
            "rank": Int(rank),
            "courage": Int(courage),
            "firepower": Int(firepower),
            "skill": Int(skill),
        ]
        
        //        let body = [String : AnyHashable] = [
        //              "id": Int(id) ?? 0,
        //              "name": name,
        //              "team": team,
        //              "strength": Int(strength) ?? 0,
        //              "intelligence": Int(intelligence) ?? 0,
        //              "speed": Int(speed) ?? 0,
        //              "endurance": Int(endurance) ?? 0,
        //              "rank": Int(rank) ?? 0,
        //              "courage": Int(courage) ?? 0,
        //              "firepower": Int(firepower) ?? 0,
        //              "skill": Int(skill) ?? 0,
        //        ]
        return body
    }
    
    func createATransformer(transformer jsonData: [String: AnyHashable], completion: @escaping (Bool)->()) {
        
        
        
        AF.request("https://transformers-api.firebaseapp.com/transformers", method: .post, parameters: jsonData,encoding: JSONEncoding.default,headers: [.authorization(bearerToken: DefaultsHelper.shared.retrieveValue(keyForSavedValue: "token", savedValueType: .String) as? String ?? String())]) {$0.timeoutInterval = 5}
            .response { response in
                
                print(response.debugDescription)
                
                let code = String(response.response?.statusCode ?? 0)
                let char = code.first ?? "0"
                
                if char == "2" {completion(true)}else {completion(false)}
                
            }
    }
    
    
    func getTransformers(completion: @escaping ([Transformer])->()) {
        
        var transformersOnServer = [Transformer]()
        
        AF.request("https://transformers-api.firebaseapp.com/transformers", method: .get,headers: [.authorization(bearerToken: DefaultsHelper.shared.retrieveValue(keyForSavedValue: "token", savedValueType: .String) as? String ?? String())]).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                let transformers = json["transformers"].array
                
                guard let transformers = transformers else {
                    completion(transformersOnServer)
                    return
                }
                
                for jsonTransformer in transformers {
                    let obj = Transformer(json: jsonTransformer)
                    transformersOnServer.append(obj)
                }
                
                completion(transformersOnServer)
                
            case .failure(let error):
                print(error)
                completion(transformersOnServer)
            }
        }
    }
    
    func getTransformerImages(transformers: [Transformer], completion: @escaping ([TransformerTableViewModel])->()) {
        
        var transformerTVmodel = [TransformerTableViewModel]()
        let myGroup = DispatchGroup()

        
        for i in transformers {
            
            myGroup.enter()
            
            AF.request(i.team_icon, method: .get ,headers: [.authorization(bearerToken: DefaultsHelper.shared.retrieveValue(keyForSavedValue: "token", savedValueType: .String) as? String ?? String())]).validate().response { response in
                switch response.result {
                    
                case .success(let value):
                    
                    guard let safeData = value else {
                        let icon = UIImage()
                        let tabelviewModelObject = TransformerTableViewModel(transformer: i, teamImage: icon)
                        transformerTVmodel.append(tabelviewModelObject)
                        myGroup.leave()
                        return
                    }
                    print("retrieved image for", i.name)

                    let icon = UIImage(data: safeData) ?? UIImage()
                    
                    let tabelviewModelObject = TransformerTableViewModel(transformer: i, teamImage: icon)
                    transformerTVmodel.append(tabelviewModelObject)
                    myGroup.leave()
                case .failure(let error):
                    print(error)
                    let icon = UIImage()
                    
                    let tabelviewModelObject = TransformerTableViewModel(transformer: i, teamImage: icon)
                    transformerTVmodel.append(tabelviewModelObject)
                    myGroup.leave()
                }
            }
        }
        myGroup.notify(queue: .global(qos: .background)) {
            completion(transformerTVmodel)
        }
    }
    
    
    func deleteTransformer(id: String, completion: @escaping (Bool)->()) {

        AF.request("https://transformers-api.firebaseapp.com/transformers/\(id)", method: .delete ,headers: [.authorization(bearerToken: DefaultsHelper.shared.retrieveValue(keyForSavedValue: "token", savedValueType: .String) as? String ?? String())]).validate().responseJSON { response in
            print(response.debugDescription)
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    
    func updateTransformer(transformer jsonData: [String: AnyHashable], completion: @escaping (Bool)->()) {
        
        
        
        AF.request("https://transformers-api.firebaseapp.com/transformers", method: .put, parameters: jsonData,encoding: JSONEncoding.default,headers: [.authorization(bearerToken: DefaultsHelper.shared.retrieveValue(keyForSavedValue: "token", savedValueType: .String) as? String ?? String())]) {$0.timeoutInterval = 5}
            .response { response in
                
                print(response.debugDescription)
                
                let code = String(response.response?.statusCode ?? 0)
                let char = code.first ?? "0"
                
                if char == "2" {completion(true)}else {completion(false)}
                
            }
    }
    
    
    
    
    
    
    
}



//struct jdm: Codable {
//    let id: String
//    init(id: String) {
//        self.id = id
//    }
//}
//
//struct kkk: Codable {
//                                let  id: String
//                                let  name: String
//                                let  team: String
//                                let  strength: String
//                                let  intelligence: String
//                                let  speed: String
//                                let  endurance: String
//                                let  rank: String
//                                let  courage: String
//                                let  firepower: String
//                                let  skill: String
//    
//                                init(id: String,
//                                 name: String,
//                                 team: String,
//                                 strength: String,
//                                 intelligence: String,
//                                 speed: String,
//                                 endurance: String,
//                                 rank: String,
//                                 courage: String,
//                                 firepower: String,
//                                     skill: String) {
//                                    self. id: ,
//                                    self. name: ,
//                                    self. team: ,
//                                    self. strength: ,
//                                    self. intelligence: ,
//                                    self. speed: ,
//                                    self. endurance: ,
//                                    self. rank: ,
//                                    self. courage: ,
//                                    self. firepower: ,
//                                    self. skill:
//                                }
//}
