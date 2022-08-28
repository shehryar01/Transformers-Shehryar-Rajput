//
//  CurrentTransformersTableViewCell.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit

class CurrentTransformersTableViewCell: UITableViewCell {

    @IBOutlet weak var teamIcon: UIImageView!
    @IBOutlet weak var overallRating: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var courage: UILabel!
    @IBOutlet weak var skill: UILabel!
    
    func setCell(transformerVM: TransformerTableViewModel) {
        
        teamIcon.image = transformerVM.image
        overallRating.text = transformerVM.overallRating
        rank.text = transformerVM.rank
        courage.text = transformerVM.courage
        skill.text = transformerVM.skill
        
    }

}
