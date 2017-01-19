//
//  MatchViewController.swift
//  PickM
//
//  Created by Toby Price on 26/09/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

import UIKit

class TeamSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var day: Int?
    var match: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = customBg1
        
        let divider = UIView()
        divider.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.5)
        divider.backgroundColor = UIColor.black
        self.view.addSubview(divider)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ teamPlayersTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ teamPlayersTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamPlayersTableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableCell
        
        // Set selection colour
        let cView = UIView()
        cView.backgroundColor = customTint
        cell.selectedBackgroundView = cView
        //cell.playerNameLabel.text = eventDat.sections[day!].groups[match!].teams[0].name
        cell.tag = indexPath.row
        
        return cell
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
