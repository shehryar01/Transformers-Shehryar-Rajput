//
//  TransformerTableViewModel.swift
//  Transformers Shehryar Rajput
//
//  Created by macadmin on 28/08/2022.
//

import UIKit

// multi

struct TransformerTableViewModelList {
    let transformers: [TransformerTableViewModel]
}

extension TransformerTableViewModelList {
    
    var numberOfSections: Int {
        1
    }
    
    func numberOfRowsInSections(_ section: Int)->Int{
        transformers.count
    }
    
    func transformerAt(_ index: Int)->TransformerTableViewModel{
        transformers[index]
    }
}


// 1

struct TransformerTableViewModel {
    
   let transformer: Transformer
   let teamImage: UIImage
}

extension TransformerTableViewModel {
    var overallRating: String {
        String(transformer.overallRating)
    }
    var rank: String {
        String(transformer.rank)
    }
    var courage: String {
        String(transformer.courage)
    }
    var skill: String {
        String(transformer.skill)
    }
    var image: UIImage {
        teamImage
    }
    var id: String {
        transformer.id
    }
}
