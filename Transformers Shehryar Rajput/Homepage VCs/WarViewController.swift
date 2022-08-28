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
            
            let (zipAutobots, zipDecepticons) = zippedTransformers.reduce(([], [])) { ($0.0 + [$1.0], $0.1 + [$1.1])}
            
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

            print("\nSurvivor autobots:",survivorAutobots.count,"\nSurvivor decepticons:", survivorDecepticon.count)
            
            
            for (autobot, decepticon) in zippedTransformers{
                print(autobot.name, decepticon.name)
                let val = BattleChecker().checkIfBothAreBoss(transformer1: autobot, transformer2: decepticon)
                
                guard val == false else {print("both boss");break}
                
                let val2 = BattleChecker().checkIfThereIsABoss(transformer1: autobot, transformer2: decepticon)
                
                guard val2 == nil else {print("1 boss");return}
                
                let winner = BattleChecker().checkWhoWinsInAFight(transformer1: autobot, transformer2: decepticon)
                
                if winner?.team == "A" {
                    print("auto win")
                    autoTally += 1
                }else if winner?.team == "D"{
                    print("decepticon win")
                    decepTally += 1
                }else {
                    print("draw")
                }
            }
            
            print("\n\n")
            
            if autoTally>decepTally {
                print("Autobots WIN")
            }else if decepTally>autoTally{
                print("Decepticons WIN")
            }else {
                print("TIE")
            }
            
//            print("no boss")
            
        }
    }

}
