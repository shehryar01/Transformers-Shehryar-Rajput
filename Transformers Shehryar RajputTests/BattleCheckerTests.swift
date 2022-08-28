//
//  BattleChecker.swift
//  Transformers Shehryar RajputTests
//
//  Created by macadmin on 27/08/2022.
//

import XCTest
@testable import Transformers_Shehryar_Rajput

class BattleCheckerTests: XCTestCase {


    func testSortByRankTest() {
        
        let checker = BattleChecker()
        
        let t1 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        let t2 = Transformer(team: "", name: "", strength: 20, intelligence: 20, speed: 20, endurance: 20, rank: 20, courage: 20, firepower: 20, skill: 20, team_icon: "icon", id: String(2))
        let t3 = Transformer(team: "", name: "", strength: 30, intelligence: 30, speed: 30, endurance: 30, rank: 30, courage: 30, firepower: 30, skill: 30, team_icon: "icon", id: String(3))
        
        let transformers1 = [t1, t2, t3]
        let transformers2 = [t3, t1]
        let transformers3 = [t3, t3]
        let transformers4 = [t3]
        let transformers5 = [t1, t3]
        
        XCTAssertEqual(checker.sortByRank(transformers: transformers1), [t3, t2, t1])
        XCTAssertEqual(checker.sortByRank(transformers: transformers2), [t3, t1])
        XCTAssertEqual(checker.sortByRank(transformers: transformers3), [t3, t3])
        XCTAssertEqual(checker.sortByRank(transformers: transformers4), [t3])
        XCTAssertEqual(checker.sortByRank(transformers: transformers5), [t3, t1])

    }
    
    
    
    func testOpponentRanAwayDueToCourage() {
        
        let checker = BattleChecker()
        
        let t1 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        let t2 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 4, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.doesOpponentRunAwayDueToCourage(transformer1: t1, transformer2: t2), t2)

        
        let t3 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 4, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        let t4 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        XCTAssertEqual(checker.doesOpponentRunAwayDueToCourage(transformer1: t3, transformer2: t4), t3)
        
        XCTAssertEqual(checker.doesOpponentRunAwayDueToCourage(transformer1: t3, transformer2: t2), nil)
        
        
        
        let t5 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 9, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        let t6 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 8, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        let t7 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 7, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        let t8 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 6, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.doesOpponentRunAwayDueToCourage(transformer1: t4, transformer2: t5), nil)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToCourage(transformer1: t4, transformer2: t6), nil)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToCourage(transformer1: t4, transformer2: t7), nil)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToCourage(transformer1: t4, transformer2: t8), t8)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToCourage(transformer1: t8, transformer2: t2), nil)

    }
    
    
    func testOpponentRanAwayDueToStrength() {
        
        let checker = BattleChecker()
        
        let t1 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        let t2 = Transformer(team: "", name: "", strength: 7, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t1, transformer2: t2), t2)
        
        
        let t3 = Transformer(team: "", name: "", strength: 7, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        let t4 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t3, transformer2: t4), t3)
        
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t3, transformer2: t2), nil)
        
        
        
        let t5 = Transformer(team: "", name: "", strength: 9, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        let t6 = Transformer(team: "", name: "", strength: 8, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        let t7 = Transformer(team: "", name: "", strength: 7, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        let t8 = Transformer(team: "", name: "", strength: 6, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t4, transformer2: t5), nil)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t4, transformer2: t6), nil)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t4, transformer2: t7), t7)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t4, transformer2: t8), t8)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t8, transformer2: t2), nil)
        XCTAssertEqual(checker.doesOpponentRunAwayDueToStrength(transformer1: t4, transformer2: t1), nil)
    }

    
    
    func testOpponentWinsDueToSkill() {
        
        let checker = BattleChecker()
        
        let t1 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 7, team_icon: "icon", id: String(1))
        let t2 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t1, transformer2: t2), t2)
        
        
        let t3 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        let t4 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 7, team_icon: "icon", id: String(2))
        
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t3, transformer2: t4), t3)
        
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t3, transformer2: t2), nil)
        
        
        
        let t5 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 9, team_icon: "icon", id: String(2))
        let t6 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 8, team_icon: "icon", id: String(2))
        let t7 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 7, team_icon: "icon", id: String(2))
        let t8 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 6, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t4, transformer2: t5), nil)
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t4, transformer2: t6), nil)
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t4, transformer2: t7), nil)
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t4, transformer2: t8), nil)
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t8, transformer2: t2), t2)
        XCTAssertEqual(checker.checkWhoWinsDueToSkill(transformer1: t4, transformer2: t1), nil)
    }
    
    
    func testOpponentWinsDueToOverallRating() {
        
        
        /*
         The “overall rating” of a Transformer is the following formula
         Strength + Intelligence + Speed + Endurance + Firepower
         */
        
        let checker = BattleChecker()
        
        let t1 = Transformer(team: "", name: "", strength: 9, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        let t2 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t1, transformer2: t2), t2)
        
        
        let t3 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        let t4 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 9, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t3, transformer2: t4), t3)
        
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t3, transformer2: t2), nil)
        
        
        
        let t5 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 9, skill: 10, team_icon: "icon", id: String(2))
        let t6 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 8, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        let t7 = Transformer(team: "", name: "", strength: 10, intelligence: 7, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        let t8 = Transformer(team: "", name: "", strength: 7, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t4, transformer2: t5), nil)
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t4, transformer2: t6), t4)
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t4, transformer2: t7), t4)
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t4, transformer2: t8), t4)
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t8, transformer2: t2), t2)
        XCTAssertEqual(checker.checkWhoWinsDueToOverallRating(transformer1: t4, transformer2: t1), nil)
    }
    
    
    
    
    func testWhoWinsAFight() {
        
        
        /*
         The “overall rating” of a Transformer is the following formula
         Strength + Intelligence + Speed + Endurance + Firepower
         */
        
        
        // ******* RUN'S AWAY CHECK *********
        
        
        
        let checker = BattleChecker()
        
        let t1 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))

        let t2 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        let t3 = Transformer(team: "", name: "", strength: 7, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        let t4 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 6, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        let t5 = Transformer(team: "", name: "", strength: 7, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 6, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        let t6 = Transformer(team: "", name: "", strength: 1, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 1, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        let t7 = Transformer(team: "", name: "", strength: 6, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 6, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        let t8 = Transformer(team: "", name: "", strength: 1, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 1, firepower: 10, skill: 10, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t1, transformer2: t2), nil) // eql ops
        
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t1, transformer2: t3), t1) // 1 thing is less
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t1, transformer2: t4), nil) // 1 thing is less

        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t1, transformer2: t5), t1) // 2 things are less
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t1, transformer2: t6), t1) // 2 things are less
        
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t1, transformer2: t7), t1) // 2 things are less
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t1, transformer2: t8), t1) // 2 things are less

        
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t7, transformer2: t8), t7) // 2 things are less on both but as we wrote in pdf COMPARED TO opp, t7 has more stats and wins
        
        
        // ********* SKILL CHECK *************
        
        let t9 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))

        let t10 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 3, skill: 8, team_icon: "icon", id: String(2))
        
        let t11 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 3, skill: 7, team_icon: "icon", id: String(2))

        let t12 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 3, skill: 2, team_icon: "icon", id: String(2))
        
        let t13 = Transformer(team: "", name: "", strength: 8, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 8, firepower: 3, skill: 6, team_icon: "icon", id: String(2))
        
        
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t9, transformer2: t10), t9) // eql ops
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t9, transformer2: t11), t9)
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t9, transformer2: t12), t9)
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t9, transformer2: t13), t9)
        
        
        // **** OVERALL RATING CHECK *********
        
        let t14 = Transformer(team: "", name: "", strength: 9, intelligence: 9, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 3, skill: 2, team_icon: "icon", id: String(2))
        
        let t15 = Transformer(team: "", name: "", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 3, skill: 6, team_icon: "icon", id: String(2))
        
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t1, transformer2: t14), t1) // eql ops
        XCTAssertEqual(checker.checkWhoWinsInAFight(transformer1: t2, transformer2: t15), t9)
        
    }
    
    
    func testSpecialBoss() {
        
        
        let checker = BattleChecker()

        let t1 = Transformer(team: "", name: "Optimus Prime", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team_icon: "icon", id: String(1))
        let t2 = Transformer(team: "", name: "Predaking", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team_icon: "icon", id: String(1))
        
        let t3 = Transformer(team: "", name: "crook", strength: 10, intelligence: 10, speed: 10, endurance: 10, rank: 10, courage: 10, firepower: 10, skill: 10, team_icon: "icon", id: String(1))
        
        XCTAssertEqual(checker.checkIfThereIsABoss(transformer1: t3, transformer2: t1), t1)
        XCTAssertEqual(checker.checkIfThereIsABoss(transformer1: t2, transformer2: t3), t2)

        XCTAssertEqual(checker.checkIfThereIsABoss(transformer1: t1, transformer2: t1), nil) // same
        XCTAssertEqual(checker.checkIfThereIsABoss(transformer1: t2, transformer2: t2), nil) // same
        
        XCTAssertEqual(checker.checkIfThereIsABoss(transformer1: t1, transformer2: t2), nil) // opp
        XCTAssertEqual(checker.checkIfThereIsABoss(transformer1: t2, transformer2: t1), nil) // opp


    }
    
    
    
}
