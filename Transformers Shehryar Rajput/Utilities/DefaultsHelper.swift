//
//  DefaulsHelper.swift
//
//  Created by macadmin on 29/10/2021.
//

import Foundation

/// Interface for userdefaults
class DefaultsHelper{
    
    static var shared = DefaultsHelper()
    private init(){}
    
    
    let defaults = UserDefaults.standard
    

    
    func saveValue<T>(valueToSaveInDefaults val: T, keyForSavedValue key: String){
        defaults.set(val, forKey: key)
    }
    
    
    
    func retrieveValue(keyForSavedValue key: String, savedValueType: RetrievedValueTypes)->Any{
        
        switch savedValueType {
        case .Int:
            return defaults.object(forKey: key) as? Int ?? Int()
        case .Float:
            return defaults.object(forKey: key) as? Float ?? Float()
        case .String:
            return defaults.object(forKey: key) as? String ?? String()
        case .Bool:
            return defaults.object(forKey: key) as? Bool ?? Bool()
        case .StringDict:
            return defaults.object(forKey: key) as? [String: String] ?? [String: String]()
        case .StringArray:
            return defaults.object(forKey: key) as? [String] ?? [String]()
        }
    }

    
    func retrieveSavedItemCount(){
        print("Total saved items in defaults are: ",Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
    
}

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}


extension DefaultsHelper{
    
    enum RetrievedValueTypes{
    
        case Int, Float, String, Bool, StringDict, StringArray

}
    
}
