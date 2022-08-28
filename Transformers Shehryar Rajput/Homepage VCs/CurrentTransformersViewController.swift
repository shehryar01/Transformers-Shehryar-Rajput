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
    
    
    
}
