//
//  BattleChecker.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 27/08/2022.
//

import Foundation

struct BattleChecker {
    
    /// Sorts the transformers array you provide based on Rank, in descending order
    /// - Parameter transformers: Tranformers to sort in an array
    /// - Returns: Sorted transformer array based on rank in descending order
    func sortByRank(transformers: [Transformer]) -> [Transformer] {
        transformers.sorted(by: {$0.rank > $1.rank })
    }
    
    /// Determines if the opponent will run away based on courage, if it's 4 or more below the opponent
    /// - Parameters:
    ///   - transformer1: transformer you want to compare
    ///   - transformer2: transformer you want to compare
    /// - Returns: Optional transformer which runs away if any
    func doesOpponentRunAwayDueToCourage(transformer1: Transformer, transformer2: Transformer) -> Transformer? {
        
        let differenceInCourage = abs((transformer1.courage - transformer2.courage))
        
        guard differenceInCourage >= 4 else {return nil}
        
        // figure out who ran away
        // if we're here we're certain someone runs away bec of 4 or more gap in crge - hence find the transf who runs away
        
        return (transformer1.courage < transformer2.courage) ? transformer1 : transformer2
        
    }
    
    /// Determines if the opponent will run away based on strength, if it's 3 or more below the opponent
    /// - Parameters:
    ///   - transformer1: transformer you want to compare
    ///   - transformer2: transformer you want to compare
    /// - Returns: Optional transformer which runs away if any
    func doesOpponentRunAwayDueToStrength(transformer1: Transformer, transformer2: Transformer) -> Transformer? {
        
        let differenceInStrength = abs((transformer1.strength - transformer2.strength))
        
        guard differenceInStrength >= 3 else {return nil}
        
        // figure out who ran away
        // if we're here we're certain someone runs away bec of 3 or more gap in strn - hence find the transf who runs away
        
        return (transformer1.strength < transformer2.strength) ? transformer1 : transformer2
        
    }
    
    
    /// Compares 2 transformers and finds and returns the victor if any
    /// - Parameters:
    ///   - transformer1: transformer you want to compare
    ///   - transformer2: transformer you want to compare
    /// - Returns: The transformer that wins the battle if any otherwise returns nil
    func checkWhoWinsDueToSkill(transformer1: Transformer, transformer2: Transformer) -> Transformer? {
        
        let differenceInSkill = abs((transformer1.skill - transformer2.skill))
        
        guard differenceInSkill >= 3 else {return nil}
        
        // figure out who ran away
        // if we're here we're certain someone wins bec of 3 or more gap in skl - hence find the transf who wins
        
        return (transformer1.skill > transformer2.skill) ? transformer1 : transformer2
        
    }
    
    
    /// Compares 2 transformers based on overall rating and finds and returns the victor if any
    /// - Parameters:
    ///   - transformer1: transformer you want to compare
    ///   - transformer2: transformer you want to compare
    /// - Returns: The transformer that wins the battle if any otherwise returns nil
    func checkWhoWinsDueToOverallRating(transformer1: Transformer, transformer2: Transformer) -> Transformer? {
        
        let differenceInSkill = abs((transformer1.overallRating - transformer2.overallRating))
        
        guard differenceInSkill != 0 else {return nil} // tie, destroy both
        
        // figure out who wins
        // if we're here we're certain someone wins because its not a tie
        
        return (transformer1.overallRating > transformer2.overallRating) ? transformer1 : transformer2
        
    }
    /*
     func checkIfThereIsABoss(transformer1: Transformer, transformer2: Transformer)->Transformer? {
         
         let optimus = "Optimus Prime"
         let predaking = "Predaking"
         
         
         
         if transformer1.name == transformer2.name,
            transformer1.name == optimus || transformer1.name == predaking { // same name boss
             return nil

         }else if        transformer1.name == optimus || transformer1.name == predaking && // opp name boss
                         transformer2.name == optimus || transformer2.name == predaking {
             return nil
         }else if    transformer1.name == predaking ||
                     transformer1.name == optimus { // 1 name boss
             
                 return transformer1
             
         }else if        transformer2.name == predaking ||
                         transformer2.name == optimus { // 1 name boss
             
                         return transformer2
             }else {
                 return nil
             }
         
         

         
     }
     */
    
    func checkIfBothAreBoss(transformer1: Transformer, transformer2: Transformer)->Bool {
        
        let optimus = "Optimus Prime"
        let predaking = "Predaking"

        if transformer1.name == transformer2.name ,
           transformer1.name == optimus || transformer1.name == predaking { // same name boss
            return true

        }else if        transformer1.name == optimus || transformer1.name == predaking , // opp name boss
                        transformer2.name == optimus || transformer2.name == predaking {
            return true
        }else {
            return false
        }
    }
    func checkIfThereIsABoss(transformer1: Transformer, transformer2: Transformer)->Transformer? {
        
        let optimus = "Optimus Prime"
        let predaking = "Predaking"
        
        
//        guard !checkIfBothAreBoss(transformer1: transformer1, transformer2: transformer2) else {return nil}
        
        
        if          transformer1.name == predaking ||
                    transformer1.name == optimus { // 1 name boss
            
                return transformer1
            
        }else if        transformer2.name == predaking ||
                        transformer2.name == optimus { // 1 name boss
            
                return transformer2
            
            }else {
                return nil
            }
        
        

        
    }
    
    func checkWhoWinsInAFight(transformer1: Transformer, transformer2: Transformer) -> Transformer? {
        
        

        
        
        if doesOpponentRunAwayDueToCourage(transformer1: transformer1, transformer2: transformer2) ==
            doesOpponentRunAwayDueToStrength(transformer1: transformer1, transformer2: transformer2),
            
            doesOpponentRunAwayDueToStrength(transformer1: transformer1, transformer2: transformer2) != nil &&
            doesOpponentRunAwayDueToStrength(transformer1: transformer1, transformer2: transformer2) != nil { // check who runs away
            
            // someone ran away
            
            return doesOpponentRunAwayDueToStrength(transformer1: transformer1, transformer2: transformer2) == transformer1 ? transformer2 : transformer1
            
        }else if checkWhoWinsDueToSkill(transformer1: transformer1, transformer2: transformer2) != nil { // check skill
            
            return checkWhoWinsDueToSkill(transformer1: transformer1, transformer2: transformer2)
            
            
        }else if checkWhoWinsDueToOverallRating(transformer1: transformer1, transformer2: transformer2) != nil { // check overall rating
            
            return checkWhoWinsDueToOverallRating(transformer1: transformer1, transformer2: transformer2)
            
            
        }else {
            
            // draw - kill both            
            
            
            return nil
        }
    }
    
}
