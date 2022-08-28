//
//  WarViewController.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit

class WarViewController: UIViewController {

    var transformersTableVM: TransformerTableViewModelList!
    var autobots = [Transformer]()
    var decepticons = [Transformer]()
    
    @IBOutlet weak var outputwindow: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        
        
    }
    
    func setup() {
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        

        Networker().getTransformers { [self] transformers in
            DispatchQueue.main.async {
                spinner.removeFromSuperview()
            }
            
            for i in transformers {
                if  i.team == "A" ||
                    i.team == "a" {
                    autobots.append(i)
                }else if  i.team == "D" ||
                        i.team == "d" {
                    decepticons.append(i)
                    }
            }
            
            print("autobots", autobots, autobots.count)
            print("decepticons", decepticons, decepticons.count)
            
            
            autobots = BattleChecker().sortByRank(transformers: autobots)
            decepticons = BattleChecker().sortByRank(transformers: decepticons)
            
            
            var autoTally = 0
            var decepTally = 0
            
            let zippedTransformers = zip(autobots,decepticons)
            
            var (zipAutobots, zipDecepticons) = zippedTransformers.reduce(([], [])) { ($0.0 + [$1.0], $0.1 + [$1.1])}
            
            var survivorAutobots = [Transformer]()
            var survivorDecepticon = [Transformer]()
            
            for i in autobots {
                if !zipAutobots.contains(i) {
                    survivorAutobots.append(i)
                }
            }
            for i in decepticons {
                if !zipDecepticons.contains(i) {
                    survivorDecepticon.append(i)
                }
            }

            print("\nSurvivor autobots (unparticipating):",survivorAutobots.count,"\nSurvivor decepticons (unparticipating):", survivorDecepticon.count)
            
            
            for (autobot, decepticon) in zippedTransformers{
                
                print("now fighting->", autobot.name, decepticon.name)
                
                let val = BattleChecker().checkIfBothAreBoss(transformer1: autobot, transformer2: decepticon)
                
                guard val == false else {
                    print("both are boss")
                    
                    displayResults(winningTeam: "Everyone Is Dead", message: "Optimus Prime & Predaking fought, causing total destruction", survivors: [], winners: [])
                    
                    break
                }
                
                let val2 = BattleChecker().checkIfThereIsABoss(transformer1: autobot, transformer2: decepticon)
                
                guard val2 == nil else {
                    
                    print("1 boss present")
                    
                    if let val2 = val2 {
                        
                        if val2.team == "A" {
                            
                            print("auto win")
                            
//                            Networker().deleteTransformer(id: decepticon.id) { _ in
//                            } // if you want to delete
                            
                            zipDecepticons.removeAll(where: {$0 == decepticon}) // kill the loser from the list
                            autoTally += 1

                        }else if val2.team == "D"{
                            print("decepticon win")
                            
//                            Networker().deleteTransformer(id: autobot.id) { _ in
//                            } // if you want to delete
                            
                            zipAutobots.removeAll(where: {$0 == autobot}) // kill the loser from the list
                            decepTally += 1
                        }
                }
                    break
                }
                
                let winner = BattleChecker().checkWhoWinsInAFight(transformer1: autobot, transformer2: decepticon)
                
                if winner?.team == "A" {
                    print("auto win")
                    
//                    Networker().deleteTransformer(id: decepticon.id) { _ in
//                    } // if you want to delete
                    
                    
                    zipDecepticons.removeAll(where: {$0 == decepticon}) // kill the loser from the list
                    autoTally += 1
                }else if winner?.team == "D"{
                    print("decepticon win")
                    
//                    Networker().deleteTransformer(id: autobot.id) { _ in
//                    } // if you want to delete
                    
                    zipAutobots.removeAll(where: {$0 == autobot}) // kill the loser from the list
                    decepTally += 1
                }else {
                    print("draw")
                }
            }
            
            print("\n\n")
            
            if autoTally>decepTally {
                print("Autobots WIN")
                displayResults(winningTeam: "Winning Team (Autobots)", message: "", survivors: survivorDecepticon, winners: zipAutobots)
            }else if decepTally>autoTally{
                print("Decepticons WIN")
                displayResults(winningTeam: "Winning Team (Decepticons)", message: "", survivors: survivorAutobots, winners: zipDecepticons)

            }
            
//            print("no boss")
            
        }
    }
    
    
    func displayResults(winningTeam: String, message: String, survivors s: [Transformer], winners: [Transformer]){
        
        var surv = ""

        for i in s {
            surv.append("\n-\(i.name) ")
        }

        var winrs = ""

        for i in winners {
            winrs.append("\n-\(i.name) ")
        }

        
        outputwindow.text = "\n\(winningTeam): \(winrs)\n"
        outputwindow.text.append("\n\(message)")
        guard !surv.isEmpty && !winners.isEmpty else {return}
        outputwindow.text.append("\nSurvivors from losing team: \(surv)")

        
    }
    

}
