//
//  MatchTableCell.swift
//  PickM
//
//  Created by Toby Price on 11/08/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

import UIKit

class MatchTableCell: UITableViewCell {
    
    @IBOutlet weak var cellScore: UILabel!
    @IBOutlet var cellTitle: UILabel!
    
    var cellRowNum: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        if cellRowNum == 0
        {
            //cellScore.text = "3-0"
            cellTitle.text = "Pick a team that will advance undefeated"
        }
        else if cellRowNum == 1
        {
            //cellScore.text = "0-3"
            cellTitle.text = "Pick a team that will be eliminated without winning a match"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

