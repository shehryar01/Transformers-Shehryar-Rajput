//
//  HomepageViewController.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit

class HomepageViewController: UIViewController {

    @IBOutlet weak var currentTransformers: UIButton!
    @IBOutlet weak var createTransformers: UIButton!
    @IBOutlet weak var war: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
    }
    
    func setup() {
        
        currentTransformers.layer.cornerRadius = 20
        createTransformers.layer.cornerRadius = 20
        war.layer.cornerRadius = 20
        
        
    }
    
    @IBAction func currentTransformers(_ sender: UIButton) {

        let vc = UIStoryboard.init(name: "Homepage", bundle: Bundle.main).instantiateViewController(withIdentifier: VcNames.currentTransformers.rawValue)

        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createTransformers(_ sender: UIButton) {
        
        
        let vc = UIStoryboard.init(name: "Homepage", bundle: Bundle.main).instantiateViewController(withIdentifier: VcNames.createTransformers.rawValue)

        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func startWar(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Homepage", bundle: Bundle.main).instantiateViewController(withIdentifier: VcNames.warPage.rawValue)

        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
