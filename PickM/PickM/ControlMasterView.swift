//
//  TestControlMasterView.swift
//  PickM
//
//  Created by Toby Price on 23/09/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

import UIKit

class ControlMasterView: UIView {
    
    //var eventData = Event()
    let dayCount = 6
    let dayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 25))
    var animationDur: Double = 0.2
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var spacing: Double?
        //var margin: Double?
        let screenWidth = UIScreen.main.bounds.size.width
        let viewHeight: CGFloat = 88
        
        spacing = ((Double(screenWidth)) - (Double(dayCount) * buttonSize)) / Double(dayCount + 1)

        self.backgroundColor = customNav1
        
        //margin = ((Double(screenWidth)) - ((Double(dayCount) * buttonSize) + (Double(dayCount - 1) * spacing!))) / 2
        
        for x in 0..<dayCount {
            let dayName = String(x + 1)
            let originPoint = CGFloat((Double(x) * (buttonSize + spacing!)) + spacing!)
            let button = UIButton()
            
            button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
            button.frame.origin.x = CGFloat(originPoint)
            button.frame.origin.y = (viewHeight - CGFloat(buttonSize + 50))
            button.setTitle(dayName, for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = CGFloat(Double(buttonSize / 2))
            
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = customNav1
            
            button.addTarget(self, action: #selector(ControlMasterView.buttonTapped(button:notTapped:)), for: .touchDown)
            
            if x == 0 {
                button.isSelected = true
                button.backgroundColor = customTint
                button.setTitleColor(customNav1, for: .normal)
            }
            
            addSubview(button)
        }
        
        dayLabel.font = UIFont(name: dayLabel.font.fontName, size: 18)
        dayLabel.textAlignment = NSTextAlignment.center
        dayLabel.center = CGPoint(x: screenWidth / 2, y: viewHeight - CGFloat(30))
        dayLabel.textColor = UIColor.white
        dayLabel.text = eventDat.days[0].name
        print(eventDat.days[0].name)
        
        self.addSubview(dayLabel)
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: viewHeight, width: screenWidth, height: 0.8)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        
        self.layer.addSublayer(bottomBorder)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func buttonTapped(button: UIButton, notTapped: Bool) {
        for y in (self.subviews) {
            if let btn = y as? UIButton {
                btn.isSelected = false
                
                btn.setTitleColor(UIColor.white, for: .normal)
                
                UIView.animate(withDuration: animationDur, delay: 0, options: .allowUserInteraction, animations: { btn.backgroundColor = customNav1 }, completion: nil)
            }
        }
        
        // Sets decoration for the button that was selected, animating the colour change
        button.isSelected = true
        button.setTitleColor(customNav1, for: .normal)
        UIView.animate(withDuration: animationDur, delay: 0, options: .allowUserInteraction, animations: { button.backgroundColor = customTint }, completion: nil)
        
        self.dayLabel.text = eventDat.days[Int((button.titleLabel?.text)!)! - 1].name
        
        // Gets the parent view controller, in this case the MasterViewController
        var parentViewResponder: UIViewController? {
            var parentResponder: UIResponder? = self
            
            while parentResponder != nil {
                parentResponder = parentResponder!.next
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
        
        if !notTapped {
            let pageController = parentViewResponder!.childViewControllers[0] as! ManagePageViewController
            pageController.setCustomView(viewIndex: Int((button.titleLabel?.text)!)! - 1)
        }
    }
}
