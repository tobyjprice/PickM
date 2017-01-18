//
//  FirstViewController.swift
//  PickM
//
//  Created by Toby Price on 07/07/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPageViewControllerDelegate {
    
    @IBOutlet var matchTable: UITableView!
    var cellIndex: Int?
    
    // send the page index to FirstViewCOntroller
    var pageIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        eventDat.load()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.matchTable.rowHeight = UITableViewAutomaticDimension
        self.matchTable.estimatedRowHeight = 185
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //matchTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
   
    
    func tableView(_ matchTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pageIndex! == 0
        {
            return 3
        }
        else
        {
            return eventDat.sections[pageIndex!].groups.count
        }
    }
    
    func tableView(_ matchTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if pageIndex! == 0
        {
            if indexPath.row == 2
            {
                let cell = matchTable.dequeueReusableCell(withIdentifier: "groupStageCell", for: indexPath) as! GroupStageCell
                
                // Set selection colour
                let cView = UIView()
                cView.backgroundColor = customTint
                cell.selectedBackgroundView = cView
                //cell.matchCell1.text = eventData.stages[pageIndex!].matches[indexPath.row].name
                cell.tag = indexPath.row
                
                return cell
            } else
            {
                let cell = matchTable.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchTableCell
                
                // Set selection colour
                let cView = UIView()
                cView.backgroundColor = customTint
                cell.selectedBackgroundView = cView
                //cell.matchCell1.text = eventData.stages[pageIndex!].matches[indexPath.row].name
                cell.tag = indexPath.row
                
                return cell
            }
        }
        else
        {
            let cell = matchTable.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchTableCell
            
            // Set selection colour
            let cView = UIView()
            cView.backgroundColor = customTint
            cell.selectedBackgroundView = cView
            cell.matchCell1.text = eventDat.sections[pageIndex!].groups[indexPath.row].name
            cell.tag = indexPath.row
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Gets the target view controller (MatchViewController) and sets the vars day and match to their values
        let targetVC = segue.destination as? MatchViewController
        let senderCell = sender as? MatchTableCell
        
        targetVC?.day = pageIndex!
        targetVC?.match = senderCell?.tag
    }
}

