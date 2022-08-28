//
//  CurrentTransformersViewController.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit

class CurrentTransformersViewController: UIViewController {

    var transformersTableVM: TransformerTableViewModelList!
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        
    
        setup()
        
    }
    
    func setup() {
        Networker().getTransformers { transformers in
            Networker().getTransformerImages(transformers: transformers) { [weak self] transformerModels in
                self?.transformersTableVM = TransformerTableViewModelList(transformers: transformerModels)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }

    }
    

}


extension CurrentTransformersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transformersTableVM == nil ? 0 : transformersTableVM.numberOfRowsInSections(1)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrentTransformersTableViewCell
        
        let vm = transformersTableVM.transformerAt(indexPath.row)
        
        cell.setCell(transformerVM: vm)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Swipe
    func editTransformer(index: Int)  {
        print("asdsaasdsadasd")
        
        let ac = UIAlertController(title: "Enter Transformer", message: nil, preferredStyle: .alert)
        ac.addTextField()//name
        ac.addTextField()//team
        ac.addTextField()//strength
        ac.addTextField()//intelligence
        ac.addTextField()//speed
        ac.addTextField()//endurance
        ac.addTextField()//rank
        ac.addTextField()//courage
        ac.addTextField()//firepower
        ac.addTextField()//skill
        
        ac.textFields![0].placeholder = "name"
        ac.textFields![1].placeholder = "team"
        ac.textFields![2].placeholder = "strength"
        ac.textFields![3].placeholder = "intelligence"
        ac.textFields![4].placeholder = "speed"
        ac.textFields![5].placeholder = "endurance"
        ac.textFields![6].placeholder = "rank"
        ac.textFields![7].placeholder = "courage"
        ac.textFields![8].placeholder = "firepower"
        ac.textFields![9].placeholder = "skill"
        
        let vm = transformersTableVM.transformers[index]

        ac.textFields![0].text = String(vm.name)
        ac.textFields![1].text = String(vm.team)
        ac.textFields![2].text = String(vm.strength)
        ac.textFields![3].text = String(vm.intelligence)
        ac.textFields![4].text = String(vm.speed)
        ac.textFields![5].text = String(vm.endurance)
        ac.textFields![6].text = String(vm.rank)
        ac.textFields![7].text = String(vm.courage)
        ac.textFields![8].text = String(vm.firepower)
        ac.textFields![9].text = String(vm.skill)
        
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            
            var body = Networker().createJSONtoMakeTransformer(name: ac.textFields![0].text!, team: ac.textFields![1].text!, strength: ac.textFields![2].text!, intelligence: ac.textFields![3].text!, speed: ac.textFields![4].text!, endurance: ac.textFields![5].text!, rank: ac.textFields![6].text!, courage: ac.textFields![7].text!, firepower: ac.textFields![8].text!, skill: ac.textFields![9].text!)
            body["id"] = vm.id
            
            Networker().updateTransformer(transformer: body) { [weak self] didUpdate in
                if didUpdate {
                    self?.setup()
                }
            }
            
            
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
        
        
    }
    
    func deleteTransformer(index: Int)  {
        let id = transformersTableVM.transformers[index].id
        
        Networker().deleteTransformer(id: id) {[weak self] didDelete in
            if didDelete {
                self?.setup()
            }
    }
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.editTransformer(index: indexPath.row)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteTransformer(index: indexPath.row)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
}
