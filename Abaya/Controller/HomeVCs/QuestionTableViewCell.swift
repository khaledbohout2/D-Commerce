//
//  QuestionTableViewCell.swift
//  Blocks
//
//  Created by Khaled Bohout on 7/3/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(qusetion: Question) {
        self.questionLbl.text = qusetion.question
        self.answerLbl.text = qusetion.answer
    }
}
