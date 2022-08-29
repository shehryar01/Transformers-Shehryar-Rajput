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
        

        Networker().getTransformers { [weak self] transformers in
            DispatchQueue.main.async {
                spinner.removeFromSuperview()
            }
            
            guard let strongSelf = self else {return}
            
            
            // empty transformers
            guard !transformers.isEmpty else {
                self?.displayResults(winningTeam: "", message: "Please create transformers first, to start a war", survivors: [], winners: [])
                return
            }
            
            for i in transformers {
                if  i.team == "A" ||
                    i.team == "a" {
                    strongSelf.autobots.append(i)
                }else if  i.team == "D" ||
                        i.team == "d" {
                    strongSelf.decepticons.append(i)
                    }
            }
            
            // 1 of the transformers is empty
            guard !strongSelf.autobots.isEmpty && !strongSelf.decepticons.isEmpty else {
                strongSelf.displayResults(winningTeam: "", message: "Please create at least 1 transformer per faction, to start a war", survivors: [], winners: [])
                return
            }
            
            print("autobots", strongSelf.autobots, strongSelf.autobots.count)
            print("decepticons", strongSelf.decepticons, strongSelf.decepticons.count)
            
            
            strongSelf.autobots = BattleChecker().sortByRank(transformers: strongSelf.autobots)
            strongSelf.decepticons = BattleChecker().sortByRank(transformers: strongSelf.decepticons)
            
            
            var autoTally = 0
            var decepTally = 0
            
            let zippedTransformers = zip(strongSelf.autobots,strongSelf.decepticons)
            
            var (zipAutobots, zipDecepticons) = zippedTransformers.reduce(([], [])) { ($0.0 + [$1.0], $0.1 + [$1.1])}
            
            var unpAutobots = [Transformer]()
            var unpDeceptiocons = [Transformer]()
            
            for i in strongSelf.autobots {
                for j in zipAutobots {
                    if i.id != j.id {
                        print("not participation auto")
                        unpAutobots.append(i)
                    }
                }
            }
            
            for i in strongSelf.decepticons {
                for j in zipDecepticons {
                    if i.id != j.id {
                        print("not participating deceptiocn")
                        unpDeceptiocons.append(i)
                    }
                }
            }
            
            var survivorAutobots = [Transformer]()
            var survivorDecepticon = [Transformer]()
            
            for i in strongSelf.autobots {
                if !zipAutobots.contains(i) {
                    survivorAutobots.append(i)
                }
            }
            for i in strongSelf.decepticons {
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
                    
                    strongSelf.displayResults(winningTeam: "Everyone Is Dead", message: "Optimus Prime & Predaking fought, causing total destruction", survivors: [], winners: [])
                    
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
                            let dIdx = zipDecepticons.firstIndex(where: {$0 == decepticon})
                            zipDecepticons.remove(at: dIdx!)
//                            zipDecepticons.removeAll(where: {$0 == decepticon}) // kill the loser from the list
                            autoTally += 1

                        }else if val2.team == "D"{
                            print("decepticon win")
                            
//                            Networker().deleteTransformer(id: autobot.id) { _ in
//                            } // if you want to delete
                            let idx = zipAutobots.firstIndex(where: {$0 == autobot})
                            zipAutobots.remove(at: idx!)
//                            zipAutobots.removeAll(where: {$0 == autobot}) // kill the loser from the list
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
                    
                    let dIdx = zipDecepticons.firstIndex(where: {$0 == decepticon})
                    zipDecepticons.remove(at: dIdx!)
                    
//                    zipDecepticons.removeAll(where: {$0 == decepticon}) // kill the loser from the list
                    autoTally += 1
                }else if winner?.team == "D"{
                    print("decepticon win")
                    
//                    Networker().deleteTransformer(id: autobot.id) { _ in
//                    } // if you want to delete
                    let idx = zipAutobots.firstIndex(where: {$0 == autobot})
                    zipAutobots.remove(at: idx!)
//                    zipAutobots.removeAll(where: {$0 == autobot}) // kill the loser from the list
                    decepTally += 1
                }else {
                    let aIdx = zipAutobots.firstIndex(where: {$0 == autobot})
                    zipAutobots.remove(at: aIdx!)
                    
                    let dIdx = zipDecepticons.firstIndex(where: {$0 == decepticon})
                    zipDecepticons.remove(at: dIdx!)
//                    zipAutobots.removeAll(where: {$0 == autobot}) // kill the loser from the list
//                    zipDecepticons.removeAll(where: {$0 == decepticon}) // kill the loser from the list
                    print("draw")
                }
            }
            
            print("\n\n")
            
            if autoTally>decepTally {
                print("Autobots WIN")
                strongSelf.displayResults(winningTeam: "Winning Team (Autobots)", message: "", survivors: zipDecepticons + unpDeceptiocons, winners: zipAutobots + unpAutobots)
            }else if decepTally>autoTally{
                print("Decepticons WIN")
                strongSelf.displayResults(winningTeam: "Winning Team (Decepticons)", message: "", survivors: zipAutobots + unpAutobots, winners: zipDecepticons + unpDeceptiocons)

            }else if decepTally == autoTally {
                
                let a = zipAutobots + survivorAutobots + unpAutobots
                let d = zipDecepticons + survivorDecepticon + unpDeceptiocons
                
                strongSelf.tie(message: "Game ended in a draw", autoLeft: a, decepLeft: d)
            }
            
            
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
    
    func tie(message: String, autoLeft aL: [Transformer], decepLeft dL: [Transformer]){
        
        var aLtxt = ""

        for i in aL {
            aLtxt.append("\n-\(i.name) ")
        }
        var dLtxt = ""

        for i in dL {
            dLtxt.append("\n-\(i.name) ")
        }
        outputwindow.text.append("\n\(message)")
        outputwindow.text.append("\nRemaining autobots: \(aLtxt)\n")
        outputwindow.text.append("\nRemaining decepticons: \(dLtxt)")

        

    }
    
    
    
}
