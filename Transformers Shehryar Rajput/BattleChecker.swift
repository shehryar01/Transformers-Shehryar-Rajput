//
//  BattleChecker.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 27/08/2022.
//

import Foundation

struct BattleChecker {
    
    func sortByRank(transformers: [Transformer]) -> [Transformer] {
        transformers.sorted(by: {$0.rank > $1.rank })
    }
    
    func doesOpponentRunAwayDueToCourage(transformer1: Transformer, transformer2: Transformer) -> Transformer? {
        
        let differenceInCourage = abs((transformer1.courage - transformer2.courage))
        
        guard differenceInCourage >= 4 else {return nil}
        
        // figure out who ran away
        // if we're here we're certain someone runs away bec of 4 or more gap in crge - hence find the transf who runs away
        
        return (transformer1.courage < transformer2.courage) ? transformer1 : transformer2
        
    }
    
    func doesOpponentRunAwayDueToStrength(transformer1: Transformer, transformer2: Transformer) -> Transformer? {
        
        let differenceInStrength = abs((transformer1.strength - transformer2.strength))
        
        guard differenceInStrength >= 3 else {return nil}
        
        // figure out who ran away
        // if we're here we're certain someone runs away bec of 3 or more gap in crge - hence find the transf who runs away
        
        return (transformer1.strength < transformer2.strength) ? transformer1 : transformer2
        
    }
    
}
