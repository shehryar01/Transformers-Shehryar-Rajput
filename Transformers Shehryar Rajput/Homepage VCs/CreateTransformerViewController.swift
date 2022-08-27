//
//  CreateTransformerViewController.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit

class CreateTransformerViewController: UIViewController {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var strength: UITextField!
    
    
    var activeTextField = UITextField()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        strength.delegate = self
    }
    

    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        activeTextField.text = String(Int(stepper.value))

    }
    
    @IBAction func didClickField(_ sender: UITextField) {
        
    }
    
    

}

extension CreateTransformerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("editing")
        textField.text = String(Int(stepper.value))
        activeTextField = textField

        
    }
        
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        let textFieldVal = Int(textField.text ?? "1")
        
        if let safeTextFieldVal = textFieldVal{
            
            if safeTextFieldVal > 10 {
                textField.text = "10"
            }else if safeTextFieldVal < 1 {
                textField.text = "1"
            }

        }else {
            textField.text = "1"
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    
}
