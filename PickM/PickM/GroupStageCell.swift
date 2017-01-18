//
//  GroupStageCell.swift
//  
//
//  Created by Toby Price on 13/01/2017.
//
//

import UIKit

class GroupStageCell: UITableViewCell {

    @IBOutlet var teamPicks: [UIButton]!
    
    @IBAction func teamPickedUp(_ sender: UIButton) {
        //sender.setTitleColor(customTint, for: .normal)
        //UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { sender.backgroundColor = UIColor.clear; sender.setTitleColor(customTint, for: .normal) }, completion: nil)
        
    }
    
    @IBAction func teamPickedDown(_ sender: UIButton) {
        //sender.setTitleColor(customBg1, for: .selected)
        if sender.isSelected == true {
            UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { sender.backgroundColor = UIColor.clear; sender.setTitleColor(customTint, for: .normal) }, completion: nil)
            sender.isSelected = false
        }
        else
        {
            UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { sender.backgroundColor = customTint; sender.setTitleColor(customBg1, for: .highlighted) }, completion: nil)
            sender.isSelected = true
        }
        
        
    }
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var btnIndex = 0
        for button in teamPicks
        {
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = customTint.cgColor
            
            button.imageView?.contentMode = UIViewContentMode.scaleAspectFill
            button.setImage(eventDat.sections[0].groups[0].teams[btnIndex].logo, for: .normal)
            
            btnIndex += 1
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
