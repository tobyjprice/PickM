//
//  GroupStageCell.swift
//  
//
//  Created by Toby Price on 13/01/2017.
//
//

import UIKit

class GroupStageCell: UITableViewCell {

    var teamPickCount = 0
    
    @IBOutlet var teamPicks: [UIButton]!
    
    @IBAction func teamPickedUp(_ sender: UIButton) {

    }
    
    @IBAction func teamPickedDown(_ sender: UIButton) {
        if sender.isSelected == true {
            UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { sender.backgroundColor = UIColor.clear; sender.setTitleColor(customTint, for: .normal) },completion: nil)
            teamPickCount -= 1
            sender.isSelected = false
        }
        else
        {
            if teamPickCount < 7
            {
                UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { sender.backgroundColor = customTint; sender.setTitleColor(customBg1, for: .highlighted) },completion: nil)
                teamPickCount += 1
                sender.isSelected = true
            }
        }
        
        if teamPickCount == 7
        {
            for button in teamPicks
            {
                if button.isSelected == false
                {
                    button.isUserInteractionEnabled = false
                    UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { button.alpha = 0.2 },completion: nil)
                    button.backgroundColor = customBg1
                }
            }
        }
        else
        {
            for button in teamPicks
            {
                if button.isSelected == false
                {
                    button.isUserInteractionEnabled = true
                    button.backgroundColor = customBg1
                    UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: { button.alpha = 1 },completion: nil)
                }
            }
        }
            
        print(teamPickCount)
    }
    
    func setButtonPickStatus(button: UIButton)
    {
        for pick in playerDat.picks
        {
            if pick.groupId == eventDat.sections[0].groups[0].id
            {
                if pick.pick == button.tag
                {
                    if pick.index < 8 && pick.index > 0
                    {
                        button.isSelected = true
                        button.backgroundColor = customTint
                        teamPickCount += 1
                    }
                    else if pick.index == 0
                    {
                        button.isUserInteractionEnabled = false
                        button.backgroundColor = customBg1
                        button.alpha = 0.2
                    }
                    else if pick.index == 8
                    {
                        button.isUserInteractionEnabled = false
                        button.backgroundColor = customBg1
                        button.alpha = 0.2
                    }
                }
            }
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
            button.backgroundColor = customBg1
            button.imageView?.contentMode = UIViewContentMode.scaleAspectFill
            button.setImage(eventDat.sections[0].groups[0].teams[btnIndex].logo, for: .normal)
            button.tag = eventDat.sections[0].groups[0].teams[btnIndex].id
            
            setButtonPickStatus(button: button)
            
            btnIndex += 1
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
