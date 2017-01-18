//
//  MasterViewController.swift
//  PickM
//
//  Created by Toby Price on 22/09/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventDat = Event()
        
        let nav = self.navigationController?.navigationBar
        nav?.isTranslucent = false
        
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        
        self.navigationController?.navigationBar.barTintColor = customNav1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateControl(index: Int) {
        for view in self.view.subviews {
            if view.tag == 1 {
                var temp = 0
                for button in view.subviews {
                    if temp == index && button is UIButton {
                        let tempView = view as! ControlMasterView
                        let btn = button as! UIButton
                        
                        tempView.buttonTapped(button: btn, notTapped: true)
                    }
                    temp += 1
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
