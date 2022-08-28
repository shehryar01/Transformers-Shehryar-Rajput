//
//  Transformer.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 27/08/2022.
//

import Foundation
import SwiftyJSON



class Transformer: Comparable {

    
    var id: String
    let team: String
    let name: String
    
    let strength: Int
    let intelligence: Int
    let speed: Int
    let endurance: Int
    let rank: Int
    let courage: Int
    let firepower: Int
    let skill: Int
    
    var team_icon: String

    var overallRating : Int {
        strength + intelligence + speed + endurance + firepower
    }
    
    
    init(team: String, name: String, strength: Int, intelligence: Int, speed: Int,
         endurance: Int,
         rank: Int,
         courage: Int,
         firepower: Int,
         skill: Int,
         team_icon: String,
         id: String) {
        
        self.team = team
        self.name = name
        self.strength = strength
        self.intelligence = intelligence
        self.speed = speed
        self.endurance = endurance
        self.rank = rank
        self.courage = courage
        self.firepower = firepower
        self.skill = skill
        self.team_icon = team_icon
        self.id = id
    }
    
    /// Used to create transformer via json object
    init(json: JSON) {
        
        self.team = json["team"].stringValue
        self.name = json["name"].stringValue
        self.strength = json["strength"].intValue
        self.intelligence = json["intelligence"].intValue
        self.speed = json["speed"].intValue
        self.endurance = json["endurance"].intValue
        self.rank = json["rank"].intValue
        self.courage = json["courage"].intValue
        self.firepower = json["firepower"].intValue
        self.skill = json["skill"].intValue
        self.team_icon = json["team_icon"].stringValue
        self.id = json["id"].stringValue
    }
    
    
    // MARK: - Comparing
    
    static func < (lhs: Transformer, rhs: Transformer) -> Bool {
        lhs.rank < rhs.rank
    }
    
    static func == (lhs: Transformer, rhs: Transformer) -> Bool {
        lhs.rank == rhs.rank && lhs.courage == rhs.courage && lhs.skill == rhs.skill
    }

    static func > (lhs: Transformer, rhs: Transformer) -> Bool {
        lhs.rank > rhs.rank
    }
    
    
    
}
