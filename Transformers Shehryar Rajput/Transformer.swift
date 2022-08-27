//
//  Transformer.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 27/08/2022.
//

import Foundation

class Transformer: Comparable {

    
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
    var id: Int
    
    init(team: String, name: String, strength: Int, intelligence: Int, speed: Int,
         endurance: Int,
         rank: Int,
         courage: Int,
         firepower: Int,
         skill: Int,
         team_icon: String,
         id: Int) {
        
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
    
    // MARK: - Comparing
    
    static func < (lhs: Transformer, rhs: Transformer) -> Bool {
        lhs.rank < rhs.rank
    }
    
    static func == (lhs: Transformer, rhs: Transformer) -> Bool {
        lhs.rank == rhs.rank
    }
    
    static func > (lhs: Transformer, rhs: Transformer) -> Bool {
        lhs.rank > rhs.rank
    }
    
    
    
}
