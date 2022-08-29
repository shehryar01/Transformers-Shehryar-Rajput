//
//  CreateTransformerViewController.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit
import Alamofire

class CreateTransformerViewController: UIViewController {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var strength: UITextField!
    @IBOutlet weak var endurance: UITextField!
    @IBOutlet weak var firepower: UITextField!
    @IBOutlet weak var intelligence: UITextField!
    @IBOutlet weak var rank: UITextField!
    @IBOutlet weak var skill: UITextField!
    @IBOutlet weak var speed: UITextField!
    @IBOutlet weak var courage: UITextField!
    @IBOutlet weak var team: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var createTransformer: UIButton!
    
    @IBOutlet weak var errorMessage: UILabel!
    var activeTextField = UITextField()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        strength.delegate = self
        endurance.delegate = self
        firepower.delegate = self
        intelligence.delegate = self
        rank.delegate = self
        skill.delegate = self
        speed.delegate = self
        courage.delegate = self
        team.delegate = self
        name.delegate = self
        
        createTransformer.layer.cornerRadius = 20

        
    }
    

    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        activeTextField.text = String(Int(stepper.value))

    }
    
    @IBAction func didClickField(_ sender: UITextField) {

        
    }
    
    @IBAction func createTransformer(_ sender: UIButton) {
        
        
        guard   !endurance.text!.isEmpty,
                !firepower.text!.isEmpty,
                !intelligence.text!.isEmpty,
                !rank.text!.isEmpty,
                !skill.text!.isEmpty,
                !speed.text!.isEmpty,
                !courage.text!.isEmpty,
                !team.text!.isEmpty,
                !name.text!.isEmpty
                    
                else {return}
        
        print("create clicked")
        
        createTransformer.setTitle("Creating...", for: .disabled)
        createTransformer.isEnabled = false
        
        
        let body = Networker().createJSONtoMakeTransformer(name: name.text ?? "", team: team.text ?? "", strength: strength.text ?? "", intelligence: intelligence.text ?? "", speed: speed.text ?? "", endurance: endurance.text ?? "", rank: rank.text ?? "", courage: courage.text ?? "", firepower: firepower.text ?? "", skill: skill.text ?? "")

        
        
        Networker().createATransformer(transformer: body) { [weak self] didCreateTransformer in
            
            guard let strongSelf = self else {return}
            
            if didCreateTransformer {
                self?.setTitleForButton(text: "Success", button: (strongSelf.createTransformer)!)
            }else {
                self?.setTitleForButton(text: "Failed", button: (strongSelf.createTransformer)!)
            }
        }

        
    }
    

    func setTitleForButton(text: String, button: UIButton) {
        
        button.setTitle(text, for: .disabled)
        button.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // reset to default state
            button.setTitle("Create Transformer", for: .disabled)
            button.isEnabled = true
        }
    }
    
    func setErrorMessage(_ msg: String) {
        
        
        errorMessage.text = msg
        errorMessage.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now()+3) { [weak self] in
            self?.errorMessage.isHidden = true
        }
    }
    
    
}


// MARK: - textfields

extension CreateTransformerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("editing")
        
        guard textField != team else {return}
        
        textField.text = String(Int(stepper.value))
        activeTextField = textField

        
    }
        
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        guard textField != team else {
            
            var teamText = textField.text ?? ""
            teamText = teamText.replacingOccurrences(of: " ", with: "")
            
            if textField == team {
                if teamText != "A" && teamText != "D" {
                    setErrorMessage("Team can either be A or B")
                }
            }
            
            return
        }
        
        let textFieldVal = Int(textField.text ?? "1")
        
        if let safeTextFieldVal = textFieldVal{
            
            if safeTextFieldVal > 10 {
                textField.text = "10"
            }else if safeTextFieldVal < 1 {
                textField.text = "1"
            }

        }
    }
    
    private func tagBasedTextField(_ textField: UITextField) {
        let nextTextFieldTag = textField.tag + 1

        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tagBasedTextField(textField)
        return true
    }
    
}
