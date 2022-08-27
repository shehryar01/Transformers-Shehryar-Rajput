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
    
    
    
}
